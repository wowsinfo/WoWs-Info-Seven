import React, { Component } from 'react';
import { Platform } from 'react-native';
import { AdMobBanner } from 'react-native-admob';
import * as Anime from 'react-native-animatable';
import { TintColour } from '../../value/colour';

class AdmodBanber extends Component {
  constructor(props) {
    super(props);
    this.state = {
      success: true
    }
  }

  render() {
    const { success } = this.state;
    if (!success) return null;

    // Because of this??
    let unitID = 'ca-app-pub-5048098651344514/9965938758';
    if (Platform.OS == 'ios') unitID = 'ca-app-pub-5048098651344514/4703363983';

    return (
      <Anime.View>
        <AdMobBanner adSize='smartBannerPortrait' onAdFailedToLoad={() => this.setState({success: false})}
          adUnitID={unitID} testDevices={[AdMobBanner.simulatorId, 'd04604ce-ac57-4655-90c5-4a420f30b3dd']} />
      </Anime.View>
    )
  };
}


export { AdmodBanber };
