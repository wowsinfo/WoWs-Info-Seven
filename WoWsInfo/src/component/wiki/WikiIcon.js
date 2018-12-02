/**
 * WikiIcon.js
 * 
 * A 64x64 icon with a 'New' label 
 */

import React, { Component } from 'react';
import { View, Image, ActivityIndicator, StyleSheet } from 'react-native';
import { LOCAL } from '../../value/data';
import { Touchable } from '../common/Touchable';

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
    const { item, ...props } = this.props;
    return (
      <Touchable style={container} {...props}>
        { item.new ? <View style={[newLabel, {backgroundColor: DATA[LOCAL.theme][500]}]}/> : null }
        <Image source={{uri: item.image ? item.image : item.icon}} resizeMode='contain'
          onLoadEnd={() => this.setState({loading: false})} style={{height: 64, width: 64, borderRadius: 16}} />
        { loading ? <ActivityIndicator style={indicator}/> : null }
      </Touchable>
    )
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
