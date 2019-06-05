import React, { Component } from 'react';
import { Platform } from 'react-native';
import { AdMobBanner } from 'react-native-admob';
import * as Anime from 'react-native-animatable';
import { List } from 'react-native-paper';
import { lang } from '../../value/lang';
import { SafeAction } from '../../core';
import { LOCAL } from '../../value/data';

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

    let unitID = 'ca-app-pub-3940256099942544/6300978111';
    // let unitID = 'ca-app-pub-5048098651344514/9965938758';
    // if (Platform.OS == 'ios') unitID = 'ca-app-pub-5048098651344514/4703363983';

    return (
      <Anime.View>
        <AdMobBanner adSize='smartBannerPortrait' onAdFailedToLoad={this.hideAds}
          onAdClosed={this.hideAds}
          adUnitID={unitID} testDevices={[AdMobBanner.simulatorId]} />
      </Anime.View>
    )
  };

  hideAds = () => {
    this.setState({success: false});
    DATA[LOCAL.showBanner] = false;
  }
}

export { AdmobBanner };
