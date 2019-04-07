import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { List } from 'react-native-paper';
import { Donation, WoWsInfo, SectionTitle } from '../../component';
import { lang } from '../../value/lang';
import { APP } from '../../value/data';

class SupportMe extends Component {
  constructor(props) {
    super(props);

    this.support = [{t: lang.support_patreon, d: APP.Patreon}];
    if (GITHUB_VERSION) {
      this.support = [{t: lang.support_patreon, d: APP.Patreon},
        {t: lang.support_paypal, d: APP.PayPal},
        {t: lang.support_wechat, d: APP.WeChat}];
    }
  }

  render() {
    const { container } = styles;
    return (
      <WoWsInfo>
        <List.Section title={lang.extra_support_wowsinfo}>
          <Donation />
          { this.support.map(item => { return (
            <List.Item title={item.t} description={item.d} key={item.t}
              onPress={() => Linking.openURL(item.d)}/>
          )})}
        </List.Section>
      </WoWsInfo>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  }
});

export { SupportMe };
