import React from 'react';
import { ActivityIndicator, StyleSheet, View, Platform } from 'react-native';
import { Blue } from 'react-native-material-color';

const WoWsLoading = () => {
  const { viewStyle } = styles;
  let color = String(theme[500]) == '#ffffff' ? Blue : theme[500];
  console.log(theme[500]);
  return (
    <View style={viewStyle}>
      <ActivityIndicator color={android ? color : 'gray'} size='large'/>
    </View>
  )
}

const styles = StyleSheet.create({
  viewStyle: {
    justifyContent: global.android ? 'flex-start' : 'center',
    alignItems: 'center',
    flex: 1, paddingTop: 8
  }
})

export { WoWsLoading };