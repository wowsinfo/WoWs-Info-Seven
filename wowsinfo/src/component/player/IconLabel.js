/**
 * IconLabel.js
 *
 * A label with an icon on top
 */

import React, {Component} from 'react';
import {View, StyleSheet} from 'react-native';
import {IconButton, Text} from 'react-native-paper';
import {TintColour} from '../../value/colour';

class IconLabel extends Component {
  render() {
    const {container, label} = styles;
    const {info, style, ...props} = this.props;
    console.log(style);
    return (
      <View style={[container, style]}>
        <IconButton size={36} color={TintColour()[500]} {...props} />
        <Text style={label}>{info}</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center',
    padding: 4,
  },
  label: {
    fontSize: 14,
  },
});

export {IconLabel};
