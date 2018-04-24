import React from 'react';
import { ActivityIndicator, StyleSheet, View } from 'react-native';

const WoWsLoading = () => {
  const { viewStyle } = styles;
  return (
    <View styles={viewStyle}>
      <ActivityIndicator color={global.theme}/>
    </View>
  )
}

const styles = StyleSheet.create({
  viewStyle: {
    justifyContent: 'center',
    alignItems: 'center',
    flex: 1
  }
})

export { WoWsLoading };