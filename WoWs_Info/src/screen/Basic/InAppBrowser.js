import React from 'react';
import { WebView } from 'react-native';
import { Actions } from 'react-native-router-flux';

class InAppBrowser extends React.PureComponent {
  render() {
    return (
      <WebView style={{flex: 1}} source={{uri: this.props.link}} onError={() => Actions.pop()}/>
    )
  }
}

export { InAppBrowser };
