import React, { Component } from 'react';
import { Image, Text, StyleSheet } from 'react-native';
import { View } from 'react-native-animatable';
import GridView from 'react-native-super-grid';
import { WoWsLoading, BasicCell } from '../../component';
import { navStyle, getTheme } from '../../constant/colour';

export default class Collection extends Component {
  constructor(props) {
    super(props);
    this.state = { isReady: false, data: [] }
  }

  componentWillMount() {
    let json = global.data.collection_item;
    var parsed = []; let collection = this.props.collectionKey;
    for (key in json) {
      let curr = json[key];
      if (curr.collection == collection) parsed.push(curr); // Right collection
    }    
    // Sorted by name
    parsed.sort(function(a, b) { return a.key - b.key });
    this.setState({isReady: true, data: parsed});
  }

  render() {
    if (this.state.isReady) {
      return (
        <View animation='fadeInRight'>
          <GridView itemDimension={80} items={this.state.data} ListHeaderComponent={this.renderHeader}
            renderItem={item => <BasicCell icon={item.icon} data={item} detail={() => this.props.navigator.push({
              screen: 'basic.detail',
              title: item.name,
              navigatorStyle: navStyle(),
              passProps: item
            })}/>} />
        </View>
      )
    } else return <WoWsLoading />;
  }

  renderHeader = () => {
    const { name, icon, text } = this.props.data;       
    const { viewStyle, imageStyle, nameStyle, textStyle } = styles; 
    let color = getTheme();    
    return (
      <View style={viewStyle}>
        <Image style={imageStyle} source={{uri: icon}} resizeMode='contain'/>
        <Text style={[nameStyle, {color: color}]}>{name}</Text>
        <Text style={textStyle}>{text}</Text>
      </View>
    )
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
    padding: 4,
  },
  nameStyle: {
    fontSize: 18,
    textAlign: 'center',
    padding: 4,
  },
  imageStyle: {
    height: 80, 
    width: 80,
  }
})