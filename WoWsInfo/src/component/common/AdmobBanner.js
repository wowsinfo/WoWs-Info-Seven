import React, { Component } from 'react';
import { Platform } from 'react-native';
import { AdMobBanner } from 'react-native-admob';
import * as Anime from 'react-native-animatable';
import { List } from 'react-native-paper';
import { lang } from '../../value/lang';
import { SafeAction } from '../../core';

class AdmobBanner extends Component {
  constructor(props) {
    super(props);
    this.state = {
      success: true
    }
  }

  render() {
    const { success } = this.state;
    if (!success) return (
      <List.Item title={lang.extra_support_wowsinfo} description={lang.extra_support_wowsinfo_subtitle} onPress={() => SafeAction('SupportMe')}/>
    );

    // Because of this??
    let unitID = 'ca-app-pub-5048098651344514/9965938758';
    if (Platform.OS == 'ios') unitID = 'ca-app-pub-5048098651344514/4703363983';

    return (
      <Anime.View>
        <AdMobBanner adSize='smartBannerPortrait' onAdFailedToLoad={() => this.setState({success: false})}
          onAdOpened={this.hideAds} onAdLeftApplication={this.hideAds} onAdClosed={this.hideAds}
          adUnitID={unitID} testDevices={[AdMobBanner.simulatorId, 'd04604ce-ac57-4655-90c5-4a420f30b3dd']} />
      </Anime.View>
    )
  };

  hideAds = () => {
    this.setState({success: false});
  }
}

export { AdmobBanner };
