import React, { Component } from 'react';
import { StyleSheet } from 'react-native';
import { List, Checkbox } from 'react-native-paper';
import { Donation, WoWsInfo } from '../../component';
import { lang } from '../../value/lang';
import { APP, LOCAL } from '../../value/data';
import { SafeStorage } from '../../core';

class SupportMe extends Component {
  constructor(props) {
    super(props);

    this.support = [{t: lang.support_patreon, d: APP.Patreon}];
    if (GITHUB_VERSION) {
      this.support = [{t: lang.support_patreon, d: APP.Patreon},
        {t: lang.support_paypal, d: APP.PayPal},
        {t: lang.support_wechat, d: APP.WeChat}];
    }

    this.state = {
      banner: DATA[LOCAL.showBanner],
      fullscreen: DATA[LOCAL.showFullscreen]
    };
  }

  render() {
    const { banner, fullscreen } = this.state;
    return (
      <WoWsInfo>
        <List.Section title={lang.extra_support_wowsinfo}>
          <Donation />
          { this.support.map(item => { return (
            <List.Item title={item.t} description={item.d} key={item.t}
              onPress={() => Linking.openURL(item.d)}/>
          )})}
        </List.Section>
        <List.Section title='Ads Settings'>
          <List.Item title={'Show Ads'} onPress={() => this.updateBanner(!banner)} 
            right={() => <Checkbox status={banner ? 'checked' : 'unchecked'}/>}/>
          <List.Item title={'Show Ads on launch'} onPress={() => this.updateFullscreen(!fullscreen)} 
            right={() => <Checkbox status={fullscreen ? 'checked' : 'unchecked'}/>}/>
        </List.Section>
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

export { SupportMe };
