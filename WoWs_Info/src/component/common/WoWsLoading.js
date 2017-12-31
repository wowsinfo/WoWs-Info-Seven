import React from 'react';
import { ActivityIndicator, View, StyleSheet } from 'react-native';
import { styles } from './WoWsLoadingStyles';

class WoWsLoading extends React.PureComponent {
  render() {
    const { viewStyle } = styles;
    return (
      <View style={viewStyle}>
        <ActivityIndicator color={global.themeColour} size='large'/>
      </View>
    )
  }
}

export {WoWsLoading};