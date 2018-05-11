import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { AdMobBanner } from 'react-native-admob';

class SimpleBanner extends Component {
  state = { showAds: true }
  render() {
    const { showAds } = this.state;
    if (showAds) { return (
      <View styles={styles.viewStyle}>
        { ads ? <AdMobBanner adSize={android ? 'banner' : 'smartBannerLandscape'} adUnitID='ca-app-pub-5048098651344514/4703363983'
          testDevices={[AdMobBanner.simulatorId]} onAdFailedToLoad={() => this.setState({showAds: false})}/> : null }
      </View>
    )} else return null;
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    width: '100%', flexDirection: 'row',
    alignItems: 'center', justifyContent: 'space-around'
  },
})

export { SimpleBanner };