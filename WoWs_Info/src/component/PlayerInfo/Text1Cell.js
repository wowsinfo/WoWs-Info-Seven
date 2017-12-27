import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

class Text1Cell extends React.PureComponent {
  render() {
    const { name, text } = this.props;
    return (
      <View style={viewStyle}>
        <Text numberOfLines={2} style={nameStyle}>{name}</Text>
        <Text style={textStyle}>{text}</Text>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  nameStyle: {
    fontSize: 16,
    textAlign: 'center',
  },
  textStyle: {
    paddingTop: 4,
    fontSize: 16,
    textAlign: 'center',
  },
  viewStyle: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  }
})
const { nameStyle, textStyle, viewStyle } = styles;

export {Text1Cell};