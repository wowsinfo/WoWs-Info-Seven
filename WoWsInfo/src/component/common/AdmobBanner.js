import React, { Component } from 'react';
import { View, Platform } from 'react-native';
import { List, Button } from 'react-native-paper';
import { lang } from '../../value/lang';
import { SafeAction } from '../../core';
import { pushToProVersion } from '../../core/util/ProVersion';

class AdmobBanner extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    // Pro version
    return (
      <Button mode='contained' icon='lock-open' theme={{roundness: 0}} onPress={() => pushToProVersion()}>{lang.unlock_pro_features}</Button>
    );
  };
}

export { AdmobBanner };
