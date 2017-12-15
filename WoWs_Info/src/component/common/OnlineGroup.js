import React from 'react';
import { Text, View, StyleSheet } from 'react-native';

class OnlineGroup extends React.PureComponent {
  render() {
    return (
      <View style={viewStyle}>
        <Text style={titleStyle}>{this.props.title}</Text>
        <Text style={[textStyle, {color: global.themeColour}]}>{this.props.info}</Text>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    justifyContent: 'center',
    alignItems: 'center',
    flex: 1,
  },
  titleStyle: {
    textAlign: 'center',
    fontSize: 16,
  },
  textStyle: {
    textAlign: 'center',
  }
})
const { viewStyle, titleStyle, textStyle } = styles;

export {OnlineGroup};