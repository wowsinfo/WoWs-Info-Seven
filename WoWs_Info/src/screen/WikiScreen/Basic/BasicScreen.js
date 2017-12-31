import React from 'react';
import GridView from 'react-native-super-grid';
import { Actions } from 'react-native-router-flux';
import { WoWsLoading, BasicCell } from '../../../component';

class BasicScreen extends React.PureComponent {
  state = {
    isReady: false,
    data: [],
  }

  componentDidMount() {
    // Format data and make it readable
    this.isCollection = false;
    var parsed = []; const { info, upgrade } = this.props;
    for (key in info) {
      let curr = info[key];
      // This is commander skill
      if (curr.tier != null) parsed.push(curr);
      // This is consumable
      else if (curr.type != null) {
        if (upgrade && curr.type == 'Modernization') parsed.push(curr);
        else if (!upgrade && curr.type != 'Modernization') parsed.push(curr);
      }
      // This is collection
      else parsed.push(curr);
    }
    // Do sorting here
    let firstEntry = parsed[0];
    // Sort by tier
    if (firstEntry.tier != null) parsed.sort(function (a, b) {return (a.tier - b.tier)})
    // Sort by price
    else if (firstEntry.type != null) {
      parsed.sort(function(a, b) {
        if (!upgrade && a.type != 'Flags') return 1;
        else return a.price_credit - b.price_credit;
      })
    } else this.isCollection = true; // Special screen for you
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
          renderItem={item => <BasicCell icon={item.icon} data={item} collection={this.isCollection}/>} />
      )
    } else return <WoWsLoading />;
  }
}

export {BasicScreen};