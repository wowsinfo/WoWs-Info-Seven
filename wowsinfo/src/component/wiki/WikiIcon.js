/**
 * WikiIcon.js
 *
 * A 64x64 icon with a 'New' label
 */

import React, {Component} from 'react';
import {View, Image, StyleSheet} from 'react-native';
import {LOCAL} from '../../value/data';
import {Touchable} from '../common/Touchable';

class WikiIcon extends Component {
  render() {
    const {container, newLabel} = styles;
    const {item, scale, warship, selected, ...props} = this.props;
    let width = 80;
    if (scale) width *= scale;
    let theme = DATA[LOCAL.theme];

    let imageSrc = {uri: item.image ? item.image : item.icon};
    let defaultSrc = require('../../img/Unknown.png');
    if (NOIMAGEMODE) imageSrc = null;
    defaultSrc = null;

    if (warship) {
      return (
        <View style={container}>
          {item ? (
            item.new ? (
              <View style={[newLabel, {backgroundColor: theme[500]}]} />
            ) : null
          ) : null}
          <Image
            source={imageSrc}
            resizeMode="contain"
            defaultSource={defaultSrc}
            style={{width: width, height: width / 1.7}}
          />
        </View>
      );
    } else {
      return (
        <Touchable
          style={[container, selected ? {borderColor: theme[500]} : null]}
          {...props}>
          {item.new ? (
            <View
              style={[newLabel, {backgroundColor: DATA[LOCAL.theme][500]}]}
            />
          ) : null}
          <Image
            source={imageSrc}
            resizeMode="contain"
            defaultSource={defaultSrc}
            style={{height: width, width: width}}
          />
        </Touchable>
      );
    }
  }
}

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center',
    borderRadius: 8,
    borderWidth: 1,
    borderColor: 'transparent',
  },
  newLabel: {
    position: 'absolute',
    zIndex: 1,
    borderRadius: 99,
    bottom: 0,
    height: 8,
    width: 8,
  },
});

export {WikiIcon};
