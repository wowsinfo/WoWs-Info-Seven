import React from 'react';
import { ActivityIndicator, View, StyleSheet } from 'react-native';

class WoWsLoading extends React.PureComponent {
  render() {
    return (
      <View style={viewStyle}>
        <ActivityIndicator color={global.themeColor} size='large'/>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    justifyContent: 'center',
    alignItems: 'center',
    flex: 1,
  }
})
const { viewStyle } = styles;

export {WoWsLoading};