import React from 'react';
import { View, Text, TextInput, Button } from 'react-native';
import ModalDropdown from 'react-native-modal-dropdown';
import GridView from 'react-native-super-grid';
import { styles } from './ShipInfoScreenStyles';
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
    }  
  }

  render() {
    if (this.state.isReady) {
      const { mainViewStyle, ratingStyle, filterViewStyle, filterButtonStyle, dropdownStyle, dropdownTextStyle, inputStyle } = styles;
      return (
        <View style={mainViewStyle}>
          <Text style={ratingStyle}>Super Unicum</Text>
          <View style={[filterViewStyle, {backgroundColor: global.themeColour}]}>
            <ModalDropdown ref='nationDropdown' defaultValue={strings.filter_nation} options={this.nation} onSelect={this.filterNation} textStyle={filterButtonStyle} dropdownStyle={dropdownStyle} dropdownTextStyle={dropdownTextStyle} showsVerticalScrollIndicator={false}/>
            <ModalDropdown ref='typeDropdown' defaultValue={strings.filter_type} options={this.type} onSelect={this.filterType} textStyle={filterButtonStyle} dropdownStyle={dropdownStyle} dropdownTextStyle={dropdownTextStyle} showsVerticalScrollIndicator={false}/>
            <TextInput style={inputStyle} underlineColorAndroid='transparent'autoCorrect={false} 
              autoFocus autoCapitalize='none' clearButtonMode='while-editing' returnKeyType='search'/>
          </View>
          <GridView itemDimension={80} items={this.state.data} 
            renderItem={item => <BasicCell icon={item.image} data={item}/>} />
        </View>
      )
    } else return <WoWsLoading />;
  }
}

export {ShipInfoScreen};