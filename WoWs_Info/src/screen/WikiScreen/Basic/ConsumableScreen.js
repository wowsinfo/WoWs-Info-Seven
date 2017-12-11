import React from 'react';
import GridView from 'react-native-super-grid';
import { Actions } from 'react-native-router-flux';
import { wikiIndex } from '../../../constant/value';
import { WoWsLoading, BasicCell } from '../../../component';

class ConsumableScreen extends React.PureComponent {
  state = {
    isReady: false,
    data: [],
  }

  componentWillMount() {
    // Prase global.achievementJson and make it readable
    var parsed = [];
    for (key in global.consumableJson) {
      let consumable = global.consumableJson[key];
      if (this.props.index == wikiIndex.Upgrade) {
        if (consumable.type == 'Modernization') parsed.push(consumable);
      } else {
        if (consumable.type != 'Modernization') parsed.push(consumable);
      }
    }
    // Sort by price
    parsed.sort(function (a, b) {
      // Flag comes first
      if (a.type == 'Flags') return -1;
      // credit is cheaper than gold
      if (a.price_gold && b.price_gold) return (a.price_gold - b.price_gold);
      if (a.price_gold || b.price_gold) return 1;
      else return (a.price_credit - b.price_credit);
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
        <GridView itemDimension={80} items={this.state.data} 
          renderItem={item => <BasicCell icon={item.image}/>} />
      )
    } else return <WoWsLoading />;
  }
}

export {ConsumableScreen};