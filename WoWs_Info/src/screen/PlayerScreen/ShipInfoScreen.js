import React from 'react';
import { View, Text, TextInput } from 'react-native';
import { Button } from 'react-native-elements';
import { ShipInfoCell } from '../../component';
import ModalDropdown from 'react-native-modal-dropdown';
import GridView from 'react-native-super-grid';
import { styles } from './ShipInfoScreenStyles';
import { ShipInfo, PersonalRating } from '../../core';
import strings from '../../localization';
import { WoWsLoading } from '../../component/index';

class ShipInfoScreen extends React.PureComponent {
  constructor(props) {
    super();
    // Get nation and tyle list
    this.json = global.encyclopediaJson;    
    var nation = [];
    for (key in this.json.ship_nations) nation.push(this.json.ship_nations[key]);
    this.nation = nation;
    var type = [];
    for (key in this.json.ship_types) type.push(this.json.ship_types[key]);
    this.type = type;
    this.filter = {name: '', nation: '', type: ''};

    this.state = {
      isReady: false,
      data: [],
      overall: 0,
    }  
  }

  componentWillMount() {
    // Load data here and calculate personal rating
    let ship = new ShipInfo(this.props.id, global.server);
    ship.getShipInfo().then(json => {
      if (json != null) {
        var shipInfo = [];
        for (var i = 0; i < json.length; i++) {
          if (json[i].battle != null) shipInfo.push(json[i]);
        }
        // Sort by  rating
        shipInfo.sort(function (a, b) {return b.pr - a.pr;})
        console.log(shipInfo);
        this.shipInfo = shipInfo;
        this.overall = json.overall;
        this.setState({
          isReady: true,
          data: shipInfo,
          overall: json.overall,
        })
      }
    })
  }

  render() {
    if (this.state.isReady) {
      const { mainViewStyle, filterViewStyle, filterButtonStyle, dropdownStyle, dropdownTextStyle, inputStyle, resetBtnStyle } = styles;
      return (
        <View style={mainViewStyle}>
          <View style={[filterViewStyle, {backgroundColor: global.themeColour}]}>
            <ModalDropdown ref='nationDropdown' defaultValue={strings.filter_nation} options={this.nation} onSelect={this.filterNation} textStyle={filterButtonStyle} dropdownStyle={dropdownStyle} dropdownTextStyle={dropdownTextStyle} showsVerticalScrollIndicator={false}/>
            <ModalDropdown ref='typeDropdown' defaultValue={strings.filter_type} options={this.type} onSelect={this.filterType} textStyle={filterButtonStyle} dropdownStyle={dropdownStyle} dropdownTextStyle={dropdownTextStyle} showsVerticalScrollIndicator={false}/>
            <TextInput ref='filterInput' style={inputStyle} underlineColorAndroid='transparent' autoCorrect={false} 
              autoCapitalize='none' clearButtonMode='while-editing' returnKeyType='search' onChangeText={this.onChangeText}/>
            { this.renderResetButton() }
          </View>
          <GridView itemDimension={300} items={this.state.data} renderHeader={this.renderHeader} contentInset={{bottom: 50}}
            renderFooter={this.renderFooter} renderItem={item => <ShipInfoCell info={item}/>}/>
        </View>
      )
    } else return <WoWsLoading />;
  }

  renderResetButton() {
    return (
      <Button icon={{name: 'md-refresh', type: 'ionicon'}} 
        buttonStyle={styles.resetBtnStyle} onPress={() => {
        // Reset stuff
        this.filter = {name: '', nation: '', type: ''};
        this.refs.nationDropdown.select(-1);          
        this.refs.typeDropdown.select(-1);
        this.refs.filterInput.clear(0);
        this.setState({
          data: this.shipInfo,
          overall: this.overall,
        })
      }}/>
    )
  }

  renderHeader = () => {
    let ratingInfo = this.getOverallRatingInfo(this.state.overall);    
    return (
      <Text style={[styles.ratingStyle, {color: ratingInfo.colour}]}>{ratingInfo.comment}</Text>      
    )
  }

  renderFooter = () => {
    const { footerViewStyle, poweredStyle, totalShipStyle } = styles;
    return (
      <View style={footerViewStyle}>
        <Text style={poweredStyle}>{strings.powered_by_number}</Text>
        <Text style={totalShipStyle}>{this.state.data.length}</Text>
      </View>
    )
  }

  getOverallRatingInfo(index) {
    var ratingInfo = {};
    ratingInfo.colour = PersonalRating.getColour(index);
    ratingInfo.comment = PersonalRating.getComment(index);
    return ratingInfo;
  }

  onChangeText = (text) => {
    this.filter.name = text;
    this.filterShip();
  }

  filterNation = (index, value) => {
    // Find key
    var nationKey = '';
    for (key in this.json.ship_nations) {
      let nation = this.json.ship_nations[key];
      if (value == nation) {
        // This is the key we want
        this.filter.nation = key; 
        this.filterShip();
        break;
      }
    }   
  }

  filterType = (index, value) => {
    // Find key
    for (key in this.json.ship_types) {
      let type = this.json.ship_types[key];
      if (value == type) {
        // This is the key we want
        this.filter.type = key; 
        this.filterShip();
        break;
      }
    }
    
  }

  filterShip() {
    // Filter ship according to this.filter
    var filtered = [];
    var totalDamage = 0, totalWin = 0, totalFrag = 0, expectedDamage = 0, expectedWin = 0, expectedFrag = 0;    
    for (var i = 0; i < this.shipInfo.length; i++) {
      let entry = this.shipInfo[i];
      // Check 3 times
      let currShip = global.warshipJson[entry.ship_id];
      if (this.filter.name != '' && !currShip.name.toLowerCase().includes(this.filter.name.toLowerCase())) continue;
      if (this.filter.type != '' && currShip.type != this.filter.type) continue;
      if (this.filter.nation != '' && currShip.nation != this.filter.nation) continue;
      // Valid ship
      filtered.push(entry);
      // Also calculate new rating here
      let currRating = global.personalRatingJson[entry.ship_id];
      totalDamage += entry.avg_damage;
      totalWin += entry.win_rate;
      totalFrag += entry.avg_frag;
      expectedDamage += currRating.average_damage_dealt;
      expectedWin += currRating.win_rate;
      expectedFrag += currRating.average_frags;
    }
    // Sort by tier as always
    filtered.sort(function (a, b) {return b.pr - a.pr;})
    // Get new rating
    let pr = PersonalRating.getTotalRating(totalDamage, expectedDamage, totalWin, expectedWin, totalFrag, expectedFrag);
    this.setState({
      data: filtered,
      overall: PersonalRating.getIndex(pr),
    })
  }

}

export {ShipInfoScreen};