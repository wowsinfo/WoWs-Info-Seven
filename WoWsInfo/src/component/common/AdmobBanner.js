import React, { Component } from 'react';
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
    // Ask users to support me (especially IOS users)
    return (
      <List.Item title={lang.extra_support_wowsinfo} description={lang.extra_support_wowsinfo_subtitle} onPress={() => SafeAction('SupportMe')}/>
    );

    // Test ads
    // let unitID = 'ca-app-pub-3940256099942544/6300978111';

    // let unitID = 'ca-app-pub-5048098651344514/9965938758';
    // if (Platform.OS == 'ios') unitID = 'ca-app-pub-5048098651344514/4703363983';

    //
    // return (
    //   <Anime.View>
    //     <AdMobBanner adSize='smartBannerPortrait' onAdFailedToLoad={this.hideAds}
    //       onAdClosed={this.hideAds} adUnitID={unitID} testDevices={[AdMobBanner.simulatorId]} />
    //   </Anime.View>
    // )
  };
}

export { AdmobBanner };
