import React, { Component } from 'react';
import { View, ScrollView, Text, StyleSheet, Linking } from 'react-native';
import { WoWsTouchable } from '../../component';
import { getTheme } from '../../constant/colour';
import language from '../../constant/language';

export default class OpenSource extends Component {
  render() {
    const libraries = [{name: 'react', link: 'https://github.com/facebook/react/blob/master/LICENSE'},
    {name: 'react-native', link: 'https://github.com/facebook/react-native/blob/master/LICENSE'},
    {name: 'react-native-admob', link: 'https://github.com/sbugert/react-native-admob/blob/master/LICENSE'},
    {name: 'react-native-animatable', link: 'https://github.com/oblador/react-native-animatable/blob/master/LICENSE'},
    {name: 'react-native-device-info', link: 'https://github.com/rebeccahughes/react-native-device-info/blob/master/LICENSE'},
    {name: 'react-native-elements', link: 'https://github.com/react-native-training/react-native-elements/blob/master/LICENSE'},
    {name: 'react-native-haptic', link: 'https://github.com/AppAndFlow/react-native-haptic'},
    {name: 'react-native-in-app-utils', link: 'https://github.com/chirag04/react-native-in-app-utils/blob/master/LICENCE.txt'},
    {name: 'react-native-localization', link: 'https://github.com/stefalda/ReactNativeLocalization/blob/master/LICENSE'},
    {name: 'react-native-material-color', link: 'https://github.com/DerayGa/react-native-material-color'},
    {name: 'react-native-navigation', link: 'https://github.com/wix/react-native-navigation/blob/master/LICENSE'},
    {name: 'react-native-select-input-ios', link: 'https://github.com/markuswind/react-native-select-input-ios/blob/master/LICENSE'},
    {name: 'react-native-simple-store', link: 'https://github.com/jasonmerino/react-native-simple-store/blob/master/LICENSE'},
    {name: 'react-native-size-matters', link: 'https://github.com/nirsky/react-native-size-matters/blob/master/LICENSE'},
    {name: 'react-native-super-grid', link: 'https://github.com/saleel/react-native-super-grid/blob/master/LICENSE'},
    {name: 'react-native-tab-view', link: 'https://github.com/react-native-community/react-native-tab-view/blob/master/LICENSE.md'},
    {name: 'react-native-userdefaults-ios', link: 'https://github.com/dsibiski/react-native-userdefaults-ios'},
    {name: 'react-native-vector-icons', link: 'https://github.com/oblador/react-native-vector-icons/blob/master/LICENSE'},
    {name: 'fast-html-parser', link: 'https://github.com/ashi009/node-fast-html-parser'},
    {name: 'string-format', link: 'https://github.com/davidchambers/string-format/blob/master/MIT-LICENSE'}];

    return (
      <ScrollView>
        { libraries.map(function(value, index) {
          return (
            <WoWsTouchable key={index} onPress={() => Linking.openURL(value.link)}
              style={{borderWidth: 0.75, borderRadius: 6, elevation: 2, borderColor: getTheme(), margin: 8}}>
              <Text style={styles.textStyle}>{value.name}</Text>
            </WoWsTouchable>
        )}) }
        <Text style={styles.textStyle}>{language.why_opensource}</Text>
      </ScrollView>
    )
  }
}

const styles = StyleSheet.create({
  textStyle: {
    padding: 16, 
    fontSize: 16, fontWeight: '300'
  }
})

