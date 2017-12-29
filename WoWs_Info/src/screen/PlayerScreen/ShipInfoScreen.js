import React from 'react';
import { View, Text, TextInput } from 'react-native';
import { Button } from 'react-native-elements';
import ModalDropdown from 'react-native-modal-dropdown';
import GridView from 'react-native-super-grid';
import { styles } from './ShipInfoScreenStyles';
import { ShipInfo } from '../../core';
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
      isReady: true,
      data: [],
    }  
  }

  componentWillMount() {
    // Load data here and calculate personal rating
    let ship = new ShipInfo(this.props.id, global.server);
    ship.getShipInfo().then(json => {
      if (json != null) {
        console.log(json);
      }
    })
  }

  render() {
    if (this.state.isReady) {
      const { mainViewStyle, ratingStyle, filterViewStyle, filterButtonStyle, dropdownStyle, dropdownTextStyle, inputStyle, resetBtnStyle } = styles;
      return (
        <View style={mainViewStyle}>
          <Text style={ratingStyle}>Super Unicum</Text>
          <View style={[filterViewStyle, {backgroundColor: global.themeColour}]}>
            <ModalDropdown ref='nationDropdown' defaultValue={strings.filter_nation} options={this.nation} onSelect={this.filterNation} textStyle={filterButtonStyle} dropdownStyle={dropdownStyle} dropdownTextStyle={dropdownTextStyle} showsVerticalScrollIndicator={false}/>
            <ModalDropdown ref='typeDropdown' defaultValue={strings.filter_type} options={this.type} onSelect={this.filterType} textStyle={filterButtonStyle} dropdownStyle={dropdownStyle} dropdownTextStyle={dropdownTextStyle} showsVerticalScrollIndicator={false}/>
            <TextInput ref='filterInput' style={inputStyle} underlineColorAndroid='transparent' autoCorrect={false} 
              autoFocus autoCapitalize='none' clearButtonMode='while-editing' returnKeyType='search' onChangeText={this.onChangeText}/>
            { this.renderResetButton() }
          </View>
          <GridView itemDimension={150} items={this.state.data} 
            renderItem={item => <BasicCell icon={item.image} data={item}/>} />
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
      }}/>
    )
  }

  onChangeText = (text) => {

  }

}

export {ShipInfoScreen};