import React from 'react';
import { ActivityIndicator, StyleSheet, View, Platform } from 'react-native';

const Android = Platform.OS == 'android';
const WoWsLoading = () => {
  const { viewStyle } = styles;
  return (
    <View style={viewStyle}>
      <ActivityIndicator color={Android ? global.theme : 'gray'} size='large'/>
    </View>
  )
}

const styles = StyleSheet.create({
  viewStyle: {
    justifyContent: Android ? 'flex-start' : 'center',
    alignItems: 'center',
    flex: 1, paddingTop: 8
  }
})

export { WoWsLoading };