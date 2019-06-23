import React, { Component } from 'react';
import { View, Platform } from 'react-native';
import { BannerView } from 'react-native-fbads';
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
    const { success } = this.state;

    if (!success) {
      return (
        <List.Item title={lang.extra_support_wowsinfo} description={lang.extra_support_wowsinfo_subtitle} onPress={() => SafeAction('SupportMe')}/>
      );
    } else {
      var ID = '1143462312527881_1143866242487488';
      if (Platform.OS == 'android') ID = '1143462312527881_1143859659154813';
      return (
        <View>
          <BannerView placementId={ID}
            type='standard' onPress={this.hideAds} onError={this.logError} />
        </View>
      )
    }
  };

  hideAds = () => this.setState({success: false});
  logError = err => {
    console.log('err', err);
    this.setState({success: false});
  }
}

export { AdmobBanner };
