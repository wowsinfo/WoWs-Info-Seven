/**
 * License.js
 * 
 * 
 */

import React, { Component } from 'react';
import { Linking, FlatList, StyleSheet } from 'react-native';
import { WoWsInfo } from '../../component';
import { List } from 'react-native-paper';
import { lang } from '../../value/lang';

const libraries = [{name: 'react', link: 'https://github.com/facebook/react'},
    {name: 'react-native', link: 'https://github.com/facebook/react-native'},
    {name: 'react-native-device-detection', link: 'https://github.com/m0ngr31/react-native-device-detection'},
    {name: 'react-native-localization', link: 'https://github.com/stefalda/ReactNativeLocalization'},
    {name: 'react-native-material-color', link: 'https://github.com/DerayGa/react-native-material-color'},
    {name: 'react-native-paper', link: 'https://github.com/callstack/react-native-paper'},
    {name: 'react-native-router-flux', link: 'https://github.com/aksonov/react-native-router-flux'},
    {name: 'react-native-super-grid', link: 'https://github.com/saleel/react-native-super-grid'},
    {name: 'react-native-svg', link: 'https://github.com/react-native-community/react-native-svg'},
    {name: 'react-native-vector-icons', link: 'https://github.com/oblador/react-native-vector-icons'},
    {name: 'string-format', link: 'https://github.com/davidchambers/string-format'},
    {name: 'victory-native', link: 'https://github.com/FormidableLabs/victory-native'},
    {name: lang.app_name, link: 'https://github.com/HenryQuan/WoWs-Info'}];

class License extends Component {
  render() {
    const { container } = styles;
    return (
      <WoWsInfo>
        <FlatList data={libraries} renderItem={({item}) => {
          return <List.Item title={item.name} description={item.link}
            onPress={() => Linking.openURL(item.link)}/>
        }} keyExtractor={d => d.name}/>
      </WoWsInfo>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export { License };
