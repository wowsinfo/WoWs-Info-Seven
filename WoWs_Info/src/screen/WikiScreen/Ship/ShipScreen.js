import React from 'react';
import { FlatList, View } from 'react-native';
import { Button } from 'react-native-elements';
import ModalDropdown from 'react-native-modal-dropdown';
import GridView from 'react-native-super-grid';
import strings from '../../../localization';
import { styles } from './ShipScreenStyles';
import { Actions } from 'react-native-router-flux';
import { WoWsLoading, WarshipCell } from '../../../component';

class ShipScreen extends React.PureComponent {
  state = {
    isReady: false,
    data: [],
  }
  
  componentWillMount() {
    // Format nation and type json
    this.json = global.encyclopediaJson;   
    this.shipType = global.shipTypeJson;   
    var nation = [];
    for (key in this.json.ship_nations) nation.push(this.json.ship_nations[key]);
    this.nation = nation;
    var type = [];
    for (key in this.shipType) type.push(this.shipType[key]);
    this.type = type;
    this.tier = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];  
    this.filter = {tier: '', nation: '', type: ''};  
  }

  componentDidMount() {
    // Prase global.achievementJson and make it readable
    var parsed = [];
    for (key in global.warshipJson) {
      let ship = global.warshipJson[key];
      // Ignore ships like [Yamato]
      if (ship.name[0] == '[') continue;
      parsed.push(ship);
    }
    parsed = this.sortShip(parsed);
    // console.log(parsed);
    this.setState({
      isReady: true,
      data: parsed,
      // Then user could now filter ships
    }, () => Actions.refresh({renderTitle: this.renderFilter, right: this.renderResetButton}));
  }

  render() {
    if (this.state.isReady) {
      return (
        <GridView itemDimension={110} items={this.state.data} 
          renderItem={item => <WarshipCell data={item}/>} />
      )
    } else return <WoWsLoading />;
  }

  renderFilter = () => {
    return (
      <View style={{flex: 1, flexDirection: 'row', alignItems: 'center', justifyContent: 'center'}}>
        <ModalDropdown ref={(ref) => this.nationDropdown = ref} defaultValue={strings.filter_nation} options={this.nation} onSelect={this.filterNation} textStyle={filterButtonStyle} dropdownStyle={dropdownStyle} dropdownTextStyle={dropdownTextStyle} showsVerticalScrollIndicator={false}/>
        <ModalDropdown ref={(ref) => this.typeDropdown = ref} defaultValue={strings.filter_type} options={this.type} onSelect={this.filterType} textStyle={filterButtonStyle} dropdownStyle={dropdownStyle} dropdownTextStyle={dropdownTextStyle} showsVerticalScrollIndicator={false}/>
        <ModalDropdown ref={(ref) => this.tierDropdown = ref} defaultValue={strings.filter_tier} options={this.tier} onSelect={this.filterTier} textStyle={filterButtonStyle} dropdownStyle={dropdownStyle} dropdownTextStyle={dropdownTextStyle} showsVerticalScrollIndicator={false}/>
      </View>
    )
  }

  renderResetButton = () => {
    return (
      <Button icon={{name: 'md-refresh', type: 'ionicon'}} 
        buttonStyle={buttonStyle} onPress={() => {
        // Reset stuff
        this.filter = {tier: '', nation: '', type: ''};
        this.nationDropdown.select(-1);          
        this.typeDropdown.select(-1);          
        this.tierDropdown.select(-1);          
        this.componentDidMount()
      }}/>
    )
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
    for (key in this.shipType) {
      let type = this.shipType[key];
      if (value == type) {
        // This is the key we want
        this.filter.type = key; 
        this.filterShip();
        break;
      }
    }
    
  }

  filterTier = (index, value) => {
    this.filter.tier = parseInt(index) + 1;
    this.filterShip();    
  }

  sortShip(ship) {
    // Sort by tier, type and name
    return ship.sort(function (a, b) {
      if (a.tier == b.tier) {
        if (a.type == b.type) return (a.name > b.name) ? 1 : -1;
        else return (a.type > b.type) ? 1 : -1;
      } else return b.tier - a.tier;
    })
  }

  filterShip() {
    // Filter ship according to this.filter
    var filtered = [];
    for (key in global.warshipJson) {
      let entry = global.warshipJson[key];
      // Check 3 times
      if (entry.name[0] == '[') continue;
      if (this.filter.tier != '' && entry.tier != this.filter.tier) continue;
      if (this.filter.type != '' && entry.type != this.filter.type) continue;
      if (this.filter.nation != '' && entry.nation != this.filter.nation) continue;
      // Valid ship
      filtered.push(entry);
    }
    // Sort by tier as always
    filtered = this.sortShip(filtered);
    this.setState({
      data: filtered,
    })
  }
}

const { buttonStyle, filterButtonStyle, dropdownStyle, dropdownTextStyle } = styles;

export {ShipScreen};