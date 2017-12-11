import React from 'react';
import { Image, ActivityIndicator, View, StyleSheet, Dimensions } from 'react-native';

class WoWsLoading extends React.PureComponent {
  render() {
    return (
      <View style={viewStyle}>
        <Image style={[imageStyle, {tintColor: global.themeColor}]} source={require('../../img/LogoWhite.png')}/>
        <ActivityIndicator color={global.themeColor} size='large'/>
      </View>
    )
  }
}

let imageWidth = Dimensions.get('window').width * 0.341333 * 2;
const styles = StyleSheet.create({
  imageStyle: {
    width: imageWidth,
    height: imageWidth,
    paddingBottom: 4,
  },
  viewStyle: {
    justifyContent: 'center',
    alignItems: 'center',
    flex: 1,
  }
})
const { imageStyle, viewStyle } = styles;

export {WoWsLoading};