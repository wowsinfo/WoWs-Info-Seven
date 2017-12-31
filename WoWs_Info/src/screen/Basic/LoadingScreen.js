import React from 'react';
import { ActivityIndicator, Image, Text, View, StyleSheet, Dimensions } from 'react-native';
import { WoWsStatusBar } from '../../component/';

class LoadingScreen extends React.PureComponent {
  render() {
    return (
      <View style={ViewStyle} backgroundColor={this.props.colour}>
        <WoWsStatusBar style={ImageStyle}/>
        { this.renderLogo() }
        <ActivityIndicator color='white' size='large'/>
      </View>
    )
  }

  renderLogo() {
    const { isPro } = this.props;
    if (isPro == true) return <Image source={require('../../img/LogoPro.png')}/>   
    return <Image source={require('../../img/LogoWhite.png')}/>
  }
}

// This is the ratio I used for iPhone 7
let LogoWidth = Dimensions.get('window').width * 0.341333;
const styles = StyleSheet.create({
  ViewStyle: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  ImageStyle: {
    height: LogoWidth,
    width: LogoWidth,
  },
});
const { ViewStyle, ImageStyle } = styles;

export { LoadingScreen };
