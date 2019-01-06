/**
 * WikiIcon.js
 * 
 * A 64x64 icon with a 'New' label 
 */

import React, { Component } from 'react';
import { View, Image, StyleSheet } from 'react-native';
import { LOCAL } from '../../value/data';
import { Touchable } from '../common/Touchable';
import { LoadingIndicator } from '../common/LoadingIndicator';

class WikiIcon extends Component {
  constructor(props) {
    super(props);

    this.state = {
      loading: true
    }
  }
  
  render() {
    const { container, newLabel, indicator } = styles;
    const { loading } = this.state;
    const { item, scale, warship, selected, ...props } = this.props;
    let width = 80;
    if (scale) width *= scale;
    let theme = DATA[LOCAL.theme];

    if (warship) {
      return (
        <View style={container}>
          { item.new ? <View style={[newLabel, {backgroundColor: theme[500]}]}/> : null }
          <Image source={{uri: item.image ? item.image : item.icon, cache: 'default'}} resizeMode='contain'
            onLoadEnd={() => this.setState({loading: false})} 
            style={{width: width, height: width / 1.7, borderRadius: 8}} />
          { loading ? <LoadingIndicator style={indicator}/> : null }
        </View>
      )
    } else {
      return (
        <Touchable style={container} {...props}>
          { item.new ? <View style={[newLabel, {backgroundColor: DATA[LOCAL.theme][500]}]}/> : null }
          <Image source={{uri: item.image ? item.image : item.icon, cache: 'default'}} resizeMode='contain'
            onLoadEnd={() => this.setState({loading: false})} 
            style={[{height: width, width: width, borderRadius: 8}, 
            selected ? {borderColor: theme[500], borderWidth: 1.5, borderRadius: 8} : null]} />
          { loading ? <LoadingIndicator style={indicator}/> : null }
        </Touchable>
      )
    }
  };
}

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  newLabel: {
    position: 'absolute', zIndex: 1,
    borderRadius: 99, bottom: 0,
    height: 8, width: 8
  },
  indicator: {
    position: 'absolute',
  }
});

export { WikiIcon };
