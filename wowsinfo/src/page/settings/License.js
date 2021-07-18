/**
 * License.js
 *
 * Showing all libraries used in WoWs Info
 */

import React, {Component} from 'react';
import {Linking, StyleSheet} from 'react-native';
import {WoWsInfo} from '../../component';
import {FlatGrid} from 'react-native-super-grid';
import {List} from 'react-native-paper';
import {lang} from '../../value/lang';

const libraries = [
  {name: 'react', link: 'https://github.com/facebook/react'},
  {name: 'react-native', link: 'https://github.com/facebook/react-native'},
  {
    name: 'react-native-animatable',
    link: 'https://github.com/oblador/react-native-animatable',
  },
  {
    name: 'react-native-device-detection',
    link: 'https://github.com/m0ngr31/react-native-device-detection',
  },
  {
    name: 'react-native-exception-handler',
    link: 'https://github.com/master-atul/react-native-exception-handler',
  },
  {
    name: 'react-native-iap',
    link: 'https://github.com/dooboolab/react-native-iap',
  },
  {
    name: 'react-native-keep-awake',
    link: 'https://github.com/corbt/react-native-keep-awake',
  },
  {
    name: 'react-native-localization',
    link: 'https://github.com/stefalda/ReactNativeLocalization',
  },
  {
    name: 'react-native-material-color',
    link: 'https://github.com/DerayGa/react-native-material-color',
  },
  {
    name: 'react-native-paper',
    link: 'https://github.com/callstack/react-native-paper',
  },
  {
    name: 'react-native-router-flux',
    link: 'https://github.com/aksonov/react-native-router-flux',
  },
  {
    name: 'react-native-super-grid',
    link: 'https://github.com/saleel/react-native-super-grid',
  },
  {
    name: 'react-native-vector-icons',
    link: 'https://github.com/oblador/react-native-vector-icons',
  },
  {
    name: 'string-format',
    link: 'https://github.com/davidchambers/string-format',
  },
  {
    name: 'native-chart-experiment',
    link: 'https://github.com/HenryQuan/native-chart-experiment',
  },
  {name: lang.app_name, link: 'https://github.com/HenryQuan/WoWs-Info'},
];

class License extends Component {
  render() {
    return (
      <WoWsInfo hideAds>
        <FlatGrid
          data={libraries}
          renderItem={({item}) => {
            return (
              <List.Item
                key={item.name}
                title={item.name}
                description={item.link}
                onPress={() => Linking.openURL(item.link)}
              />
            );
          }}
          itemDimension={300}
          spacing={0}
        />
      </WoWsInfo>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export {License};
