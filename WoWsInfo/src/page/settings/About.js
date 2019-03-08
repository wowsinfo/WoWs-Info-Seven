import React, { Component } from 'react';
import { Image, StyleSheet, Dimensions, Linking } from 'react-native';
import { WoWsInfo, Touchable } from '../../component';
import { TintColour } from '../../value/colour';
import { lang } from '../../value/lang';

class About extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { touch } = styles;
    const { width, height } = Dimensions.get('window');
    let imageWidth = width > height ? height * 0.5 : width * 0.5;

    return (
      <WoWsInfo>
        <Touchable style={touch} onPress={() => Linking.openURL(lang.abour_github_link)}>
          <Image style={{tintColor: TintColour()[500], height: imageWidth, width: imageWidth }}
            source={require('../../img/Logo.png')} />
        </Touchable>
      </WoWsInfo>
    )
  };
}

const styles = StyleSheet.create({
  touch: {
    height: '100%',
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export { About };
