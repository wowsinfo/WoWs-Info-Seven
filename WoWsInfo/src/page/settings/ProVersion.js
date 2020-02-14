import React, { Component } from 'react';
import { StyleSheet } from 'react-native';
import { List, Checkbox } from 'react-native-paper';
import { Donation, WoWsInfo } from '../../component';
import { lang } from '../../value/lang';
import { LOCAL } from '../../value/data';
import { SafeStorage } from '../../core';

class ProVersion extends Component {
  constructor(props) {
    super(props);

    this.state = {
      banner: DATA[LOCAL.showBanner],
      fullscreen: DATA[LOCAL.showFullscreen]
    };
  }

  render() {
    const { banner, fullscreen } = this.state;
    return (
      <WoWsInfo hideAds>
        <List.Section title={lang.extra_support_wowsinfo}>
          <Donation />
        </List.Section>
        {/* <List.Section title={lang.support_ads}>
          <List.Item title={lang.support_ads_banner} onPress={() => this.updateBanner(!banner)} 
            right={() => <Checkbox status={banner ? 'checked' : 'unchecked'}/>}/>
          <List.Item title={lang.support_ads_fullscreen} disabled onPress={() => this.updateFullscreen(!fullscreen)} 
            right={() => <Checkbox disabled status={fullscreen ? 'checked' : 'unchecked'}/>}/>
        </List.Section> */}
      </WoWsInfo>
    )
  };

  updateBanner(val) {
    DATA[LOCAL.showBanner] = val;
    SafeStorage.set(LOCAL.showBanner, val);
    this.setState({banner: val});
  }

  updateFullscreen(val) {
    DATA[LOCAL.showFullscreen] = val;
    SafeStorage.set(LOCAL.showFullscreen, val);
    this.setState({fullscreen: val});
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  }
});

export { ProVersion };
