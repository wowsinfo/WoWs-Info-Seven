import React, { PureComponent } from 'react';
import { FlatList, View, Text, StyleSheet, Image } from 'react-native';
import GridView from 'react-native-super-grid';
import { WoWsLoading, WoWsTouchable } from '../../component';
import { navStyle } from '../../constant/colour';

const Tier = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];

export default class Ship extends PureComponent {
  constructor(props) {
    super(props);
    this.props.navigator.setOnNavigatorEvent(this.onNavigatorEvent.bind(this));
    this.state = {isReady: false, data: []}

    // Format nation and type json
    this.filter = {tier: '', nation: '', type: ''};
  }

  /**
   * Nav button pressed
   * @param {*} event 
   */
  onNavigatorEvent(event) {
    if (event.type == 'NavBarButtonPress') {
      if (event.id == 'filter') {
        this.props.navigator.showModal({
          screen: 'ship.filter',
          navigatorStyle: navStyle(),
          passProps: { filter: this.setFilter }
        })
      } else if (event.id == 'reset') {
        this.filter = {tier: '', nation: '', type: ''};
        this.setState({data: this.parsed});
      }
    }
  }

  componentWillMount() {
    // Prase global.achievementJson and make it readable
    var parsed = [];
    for (key in data.warship) {
      let ship = data.warship[key];
      // Ignore ships like [Yamato]
      if (ship.name[0] == '[') continue;
      parsed.push(ship);
    }
    this.parsed = this.sortShip(parsed);
    // console.log(parsed);
    this.setState({isReady: true, data: this.parsed});
  }

  render() {
    const { isReady, data } = this.state;
    if (isReady) {
      const { viewStyle, textStyle, imageStyle } = styles;
      return (
        <GridView itemDimension={110} items={data} showsVerticalScrollIndicator={false}
        renderItem={item => { return (
          <WoWsTouchable>
            <View style={viewStyle}>
              {data_saver ? null : <Image source={{uri: item.icon, cache: 'default'}} style={imageStyle} resizeMode='contain'/>}
              <Text style={textStyle}>{Tier[item.tier - 1] + ' ' + item.name}</Text>
            </View>
          </WoWsTouchable>
        )}} />
      )
    } else return <WoWsLoading />;
  }

  /**
   * Sort ship by tier
   * @param {*} ship 
   */
  sortShip(ship) {
    // Sort by tier, type and name
    return ship.sort(function (a, b) {
      if (a.tier == b.tier) {
        if (a.type == b.type) return (a.name > b.name) ? 1 : -1;
        else return (a.type > b.type) ? 1 : -1;
      } else return b.tier - a.tier;
    })
  }

  /**
   * Set ship filter
   */
  setFilter = (filter) => {
    this.filter = filter;
    this.filterShip();
  }

  /**
   * Filter ship with tier, type, nation
   */
  filterShip() {
    console.log(this.filter);
    if (this.filter == {tier: '', nation: '', type: ''}) return;
    // Filter ship according to this.filter
    var filtered = [];
    for (key in data.warship) {
      let entry = data.warship[key];
      // Check 3 times
      if (entry.name[0] == '[') continue;
      if (this.filter.tier != '' && entry.tier != this.filter.tier + 1) continue;
      if (this.filter.type != '' && entry.type != this.filter.type) continue;
      if (this.filter.nation != '' && entry.nation != this.filter.nation) continue;
      // Valid ship
      filtered.push(entry);
    }
    // Sort by tier as always
    filtered = this.sortShip(filtered);
    this.setState({data: filtered})
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  textStyle: {
    textAlign: 'center',
  },
  imageStyle: {
    height: 66,
    width: 112,
  }
})