import React, { Component } from 'react';
import { StyleSheet } from 'react-native';
import { WoWsInfo } from '../../component';
import { List } from 'react-native-paper';
import { lang } from '../../value/lang';

class ProVersion extends Component {
  render() {
    return (
      <WoWsInfo hideAds>
        <List.Section title={lang.unlock_pro_features}>

        </List.Section>
      </WoWsInfo>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export { ProVersion };
