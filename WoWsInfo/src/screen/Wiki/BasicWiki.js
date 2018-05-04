import React, { Component } from 'react';
import GridView from 'react-native-super-grid';
import { WoWsLoading, BasicCell } from '../../component';
import { navStyle } from '../../constant/colour';
import { View } from 'react-native-animatable';

export default class BasicWiki extends React.PureComponent {
  state = { isReady: false, data: [] };

  componentWillMount() {
    // Format data and make it readable
    this.isCollection = false;
    var parsed = []; const { info, upgrade } = this.props;  
    for (key in info) {
      let curr = info[key];
      if (curr.tier != null) parsed.push(curr); // This is commander skill
      else if (curr.type != null) { // This is consumable
        if (upgrade == true && curr.type == 'Modernization') parsed.push(curr);
        else if (upgrade != true && curr.type != 'Modernization') parsed.push(curr);
      } else parsed.push(curr); // This is collection
    }
    // Checking for ship type
    let firstEntry = parsed[0];
    // Sort by tier
    if (firstEntry.tier != null) parsed.sort(function (a, b) {return (a.tier - b.tier)})
    else if (firstEntry.type != null) { // Sort by price
      parsed.sort(function(a, b) {
        if (!upgrade && a.type != 'Flags') return 1;
        else return a.price_credit - b.price_credit;
      })
    } else if (firstEntry.hidden == null) this.isCollection = true; // Special screen for you
    // console.log(parsed);
    this.setState({isReady: true, data: parsed});
  }

  render() {
    const { isReady, data } = this.state;
    if (isReady) {
      return (
        <View animation='fadeInRight'>
          <GridView itemDimension={80} items={data}
          renderItem={item => <BasicCell icon={item.icon} data={item} collection={this.pushToCollection} 
            detail={this.pushToDetail} isCollection={this.isCollection}/>} />
        </View>
      )
    } else return <WoWsLoading />;
  }

  /**
   * Show collection item
   */
  pushToCollection = (data) => {
    this.props.navigator.push({
      screen: 'wiki.collection',
      title: data.name,
      navigatorStyle: navStyle(),
      passProps: {collectionKey: data.key, detail: this.pushToDetail, data: data}
    })
  }

  /**
   * Show basic item detail
   */
  pushToDetail = (data) => {
    this.props.navigator.push({
      screen: 'basic.detail',
      title: data.name,
      navigatorStyle: navStyle(),
      passProps: data
    })
  }
}