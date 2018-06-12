import React, { Component } from 'react';
import { View, ScrollView, Text, StyleSheet, Linking } from 'react-native';
import { SettingCell } from '../../component';
import language from '../../constant/language';

const libraries = [{name: 'react', link: 'https://github.com/facebook/react'},
    {name: 'react-native', link: 'https://github.com/facebook/react-native'},
    {name: 'react-native-admob', link: 'https://github.com/sbugert/react-native-admob'},
    {name: 'react-native-animatable', link: 'https://github.com/oblador/react-native-animatable'},
    {name: 'react-native-device-info', link: 'https://github.com/rebeccahughes/react-native-device-info'},
    {name: 'react-native-elements', link: 'https://github.com/react-native-training/react-native-elements'},
    {name: 'react-native-haptic', link: 'https://github.com/AppAndFlow/react-native-haptic'},
    {name: 'react-native-in-app-utils', link: 'https://github.com/chirag04/react-native-in-app-utils'},
    {name: 'react-native-localization', link: 'https://github.com/stefalda/ReactNativeLocalization'},
    {name: 'react-native-elevated-view', link: 'https://github.com/alekhurst/react-native-elevated-view'},
    {name: 'react-native-material-color', link: 'https://github.com/DerayGa/react-native-material-color'},
    {name: 'react-native-navigation', link: 'https://github.com/wix/react-native-navigation'},
    {name: 'react-native-select-input-ios', link: 'https://github.com/markuswind/react-native-select-input-ios'},
    {name: 'react-native-simple-store', link: 'https://github.com/jasonmerino/react-native-simple-store'},
    {name: 'react-native-size-matters', link: 'https://github.com/nirsky/react-native-size-matters'},
    {name: 'react-native-super-grid', link: 'https://github.com/saleel/react-native-super-grid'},
    {name: 'react-native-tab-view', link: 'https://github.com/react-native-community/react-native-tab-view'},
    {name: 'react-native-userdefaults-ios', link: 'https://github.com/dsibiski/react-native-userdefaults-ios'},
    {name: 'react-native-vector-icons', link: 'https://github.com/oblador/react-native-vector-icons'},
    {name: 'victory-native', link: 'https://github.com/FormidableLabs/victory-native'},
    {name: 'react-native-svg', link: 'https://github.com/react-native-community/react-native-svg'},
    {name: 'fast-html-parser', link: 'https://github.com/ashi009/node-fast-html-parser'},
    {name: 'string-format', link: 'https://github.com/davidchambers/string-format'}];

export default class OpenSource extends Component {
  render() {
    return (
      <ScrollView>
        <View>
          { libraries.map(function(value, index) {
            return <SettingCell key={index} divider title={value.name} subtitle={value.link} onPress={() => Linking.openURL(value.link)}/>
          })}
        </View>
        <View>
          <Text style={styles.textStyle}>{language.why_opensource}</Text>
        </View>
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

