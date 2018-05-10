import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { AdMobBanner } from 'react-native-admob';

class SimpleBanner extends Component {
  render() {
    return (
      <View styles={styles.viewStyle}>
        { ads ? <AdMobBanner adSize={'smartBannerLandscape'} adUnitID='ca-app-pub-5048098651344514/4703363983'
          testDevices={[AdMobBanner.simulatorId]} onAdFailedToLoad={error => console.error(error)}/> : null }
      </View>
    )
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flex: 1,
    alignItems: 'center', justifyContent: 'space-around'
  },
})

export { SimpleBanner };