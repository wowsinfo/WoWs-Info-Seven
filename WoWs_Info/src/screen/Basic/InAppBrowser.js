import React from 'react';
import { WebView } from 'react-native';

class InAppBrowser extends React.PureComponent {
  render() {
    return (
      <WebView style={{flex: 1}} source={{uri: this.props.link}}/>
    )
  }
}

export { InAppBrowser };
