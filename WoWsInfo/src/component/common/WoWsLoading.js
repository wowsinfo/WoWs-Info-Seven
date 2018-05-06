import React from 'react';
import { ActivityIndicator, StyleSheet, View, Platform } from 'react-native';
import { getTheme } from '../../constant/colour';

const WoWsLoading = () => {
  const { viewStyle } = styles;
  let color = getTheme();
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