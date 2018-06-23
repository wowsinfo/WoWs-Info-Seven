import React, { Component } from 'react';
import { View, FlatList, StyleSheet, Text } from 'react-native';
import { WoWsLoading, MapCell, WoWsTouchable } from '../../component';
import { navStyle, getTheme } from '../../constant/colour';
import * as Animatable from 'react-native-animatable';

export default class GameMap extends Component {
  state = { isReady: false, data: [] }

  componentWillMount() {
    // Prase global.achievementJson and make it readable
    var parsed = [];
    for (key in data.map) parsed.push(data.map[key]);
    // console.log(parsed);
    this.setState({isReady: true, data: parsed});
  }

  mapKey = (item) => {return item.icon}  
  render() {
    const { data, isReady } = this.state;
    if (isReady) {
      const { viewStyle, textStyle } = styles;
      return (
        <Animatable.View style={{flex: 1}} animation='fadeInRight'>
          <FlatList data={data} keyExtractor={this.mapKey} renderItem={({item}) => {
            return (
              <WoWsTouchable onPress={() => this.showMapDetail(item)}>
                <View style={viewStyle}>
                  <Text style={[textStyle, {color: getTheme()}]}>{item.name}</Text>
                </View>
              </WoWsTouchable>
            )}}/>
        </Animatable.View>
      )
    } else return <WoWsLoading />;
  }

  /**
   * Push to map detail screen
   * @param {*} item 
   */
  showMapDetail(item) {
    this.props.navigator.push({
      screen: 'map.detail',
      title: item.name,
      passProps: item,
      navigatorStyle: navStyle()
    })
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flex: 1,
    margin: 4,
    height: 50,
    justifyContent: 'center',
  },
  textStyle: {
    fontSize: 18,
    padding: 8,
    fontWeight: '300'
  }
})