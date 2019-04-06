import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { AdMobBanner } from 'react-native-admob';

class AdmodBanber extends Component {
  constructor(props) {
    super(props);
    this.state = {
      success: true
    }
  }

  render() {
    const { container } = styles;
    const { success } = this.state;
    if (!success) return null;
    return (
      <View style={container}>
        <AdMobBanner adSize='smartBannerPortrait' onAdFailedToLoad={() => this.setState({success: false})}
          adUnitID='ca-app-pub-5048098651344514/4703363983' testDevices={[AdMobBanner.simulatorId, 'd04604ce-ac57-4655-90c5-4a420f30b3dd']} />
      </View>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    height: 36
  }
});

export { AdmodBanber };
