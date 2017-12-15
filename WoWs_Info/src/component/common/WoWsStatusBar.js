import React from 'react';
import { StatusBar } from 'react-native';

class WoWsStatusBar extends React.PureComponent {
  render() {
    return (
      <StatusBar barStyle='light-content' backgroundColor={this.props.themeColour}/>
    )
  }
}

export {WoWsStatusBar};