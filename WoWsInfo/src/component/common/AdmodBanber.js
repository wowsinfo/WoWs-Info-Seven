import React, { Component } from 'react';
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
    return (
      <Anime.View style={{height: 36, backgroundColor: TintColour()[500]}} ref='admob'>
        <AdMobBanner adSize='smartBannerPortrait' onAdFailedToLoad={() => this.refs['admob'].bounceOut(600).then(() => this.setState({success: false}))}
          adUnitID='ca-app-pub-5048098651344514/4703363983' testDevices={[AdMobBanner.simulatorId, 'd04604ce-ac57-4655-90c5-4a420f30b3dd']} />
      </Anime.View>
    )
  };
}


export { AdmodBanber };
