import React from 'react';
import { FlatList, View } from 'react-native';
import GridView from 'react-native-super-grid';
import { Actions } from 'react-native-router-flux';
import { WoWsLoading, WarshipCell } from '../../../component';

class ShipScreen extends React.PureComponent {
  state = {
    isReady: false,
    data: [],
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
    }, () => Actions.refresh({title: parsed.length}));
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