import React from 'react';
import { ActivityIndicator, StyleSheet, View, Platform } from 'react-native';
import { Blue } from 'react-native-material-color';

const WoWsLoading = () => {
  const { viewStyle } = styles;
  return (
    <View style={viewStyle}>
      <ActivityIndicator color={android ? Blue : 'gray'} size='large'/>
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