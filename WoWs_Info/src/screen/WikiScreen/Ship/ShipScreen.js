import React from 'react';
import { FlatList, View } from 'react-native';
import ModalDropdown from 'react-native-modal-dropdown';
import GridView from 'react-native-super-grid';
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
    var nation = [];
    for (key in this.json.ship_nations) nation.push(this.json.ship_nations[key]);
    this.nation = nation;
    var type = [];
    for (key in this.json.ship_types) type.push(this.json.ship_types[key]);
    this.type = type;
    this.tier = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII         ', 'IX', 'X'];    
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
    // Sort by tier, type and name
    parsed.sort(function (a, b) {
      if (a.tier == b.tier) {
        if (a.type == b.type) return (a.name > b.name) ? 1 : -1;
        else return (a.type > b.type) ? 1 : -1;
      } else return b.tier - a.tier;
    })
    // console.log(parsed);
    this.setState({
      isReady: true,
      data: parsed,
      // Then user could now filter ships
    }, () => Actions.refresh({renderTitle: this.renderFilter}));
  }

  renderFilter = () => {
    return (
      <View style={{flex: 1, flexDirection: 'row', alignItems: 'center', justifyContent: 'center'}}>
        <ModalDropdown options={this.nation} onSelect={this.filterNation}/>
        <ModalDropdown options={this.type} onSelect={this.filterType}/>
        <ModalDropdown options={this.tier} onSelect={this.filterTier}/>
      </View>
    )
  }

  filterNation = (index, value) => {
    // Find key
    var nationKey = '';
    for (key in this.json.ship_nations) {
      let nation = this.json.ship_nations[key];
      if (value == nation) {
        // This is the key we want
        nationKey = key; break;
      }
    }   
    // Filter data
    var filtered = [];
    for (var i = 0; i < this.state.data.length; i++) {
      let entry = this.state.data[i];
      if (entry.nation == nationKey) {      
        filtered.push(entry);
      }
    }
    // Update data
    this.setState({
      data: filtered,
    })
  }

  filterType = (index, value) => {
    // Find key
    var typeKey = '';
    for (key in this.json.ship_types) {
      let type = this.json.ship_types[key];
      if (value == type) {
        // This is the key we want
        typeKey = key; break;
      }
    }
    // Filter data
    var filtered = [];
    for (var i = 0; i < this.state.data.length; i++) {
      let entry = this.state.data[i];
      if (entry.type == typeKey) {
        filtered.push(entry);
      }
    }
    // Update data
    this.setState({
      data: filtered,
    })
  }

  filterTier = (index, value) => {
    let tier = parseInt(index) + 1;
    var filtered = [];
    for (var i = 0; i < this.state.data.length; i++) {
      let entry = this.state.data[i];
      if (entry.tier == tier) {
        filtered.push(entry);
      }
    }
    this.setState({
      data: filtered,
    })
  }

  render() {
    if (this.state.isReady) {
      return (
        <GridView itemDimension={110} items={this.state.data} 
          renderItem={item => <WarshipCell data={item}/>} />
      )
    } else return <WoWsLoading />;
  }
}

export {ShipScreen};