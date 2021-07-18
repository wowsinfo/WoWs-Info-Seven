import React, {Component} from 'react';
import {View, Platform} from 'react-native';
import {List} from 'react-native-paper';
import {lang} from '../../value/lang';
import {SafeAction} from '../../core';

class AdmobBanner extends Component {
  constructor(props) {
    super(props);
    this.state = {
      success: true,
    };
  }

  render() {
    // Ask users to support me (especially IOS users)
    const {success} = this.state;
    return (
      <List.Item
        title={lang.extra_support_wowsinfo}
        description={lang.extra_support_wowsinfo_subtitle}
        onPress={() => SafeAction('SupportMe')}
      />
    );
  }

  hideAds = () => this.setState({success: false});
  logError = err => {
    console.log('err', err);
    this.setState({success: false});
  };
}

export {AdmobBanner};
