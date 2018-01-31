import React from 'react';
import { FlatList, View, Text } from 'react-native';
import { Icon } from 'react-native-elements';
import GridView from 'react-native-super-grid';
import strings from '../../../localization';
import { styles } from './ShipScreenStyles';
import { Actions } from 'react-native-router-flux';
import { WoWsLoading, WarshipCell, SwitcherButton } from '../../../component';

class ShipScreen extends React.PureComponent {
  constructor(props) {
    super();
    this.state = {
      isReady: false, data: []
    }

    // Format nation and type json
    this.json = global.encyclopediaJson;
    this.filter = {tier: '', nation: '', type: ''};

    var nation = [];
    for (key in this.json.ship_nations) nation.push({label: this.json.ship_nations[key], func: () => this.filterNation(key)});
    this.nation = nation;

    var type = [];
    this.shipType = global.shipTypeJson;    
    for (key in this.shipType) type.push({label: this.shipType[key], func: () => this.filterType(key)});
    this.type = type;

    let tierList = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];
    var tier = [];
    for (var i = 0; i < 10; i++) tier.push({label: tierList[i], func: () => this.filterTier(i)});
    this.tier = tier;
  }

  filterNation = (nation) => {
    this.filter.nation = nation; 
    this.filterShip();
  }

  filterType = (type) => {
    this.filter.type = type; 
    this.filterShip();
  }

  filterTier = (tier) => {
    this.filter.tier = tier + 1;
    this.filterShip();    
  }

  componentWillUnmount() {
    global.wikiAction = [];
  }

  componentWillMount() {
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
        <SwitcherButton textStyle={styles.filterTextStyle} data={this.nation} label={strings.filter_nation}/>
        <SwitcherButton textStyle={styles.filterTextStyle} data={this.type} label={strings.filter_type}/>
        <SwitcherButton textStyle={styles.filterTextStyle} data={this.tier} label={strings.filter_tier}/>
        <Text style={numberStyle}>{this.state.data.length}</Text>
      </View>
    )
  }

  renderResetButton = () => {
    return (
      <Icon name='md-refresh' type='ionicon' color='white' underlayColor='transparent'
        containerStyle={buttonStyle} onPress={() => {
        // Reset stuff
        this.filter = {tier: '', nation: '', type: ''};      
        this.componentDidMount()
      }}/>
    )
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
    console.log(this.filter);
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

const { buttonStyle, filterButtonStyle, dropdownStyle, dropdownTextStyle, numberStyle } = styles;

export {ShipScreen};