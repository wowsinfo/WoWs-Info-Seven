import React from 'react';
import { Text } from 'react-native';
import GridView from 'react-native-super-grid';
import { Actions } from 'react-native-router-flux';
import { WikiCell } from '../../component';
import strings from '../../localization';

const WikiList = [
  { name: strings.achievement, icon: '', index: 0},
  { name: strings.flag_camouflage, icon: '', index: 1},
  { name: strings.warship, icon: '', index: 2},  
  { name: strings.commander, icon: '', index: 3},
  { name: strings.upgrade, icon: '', index: 4},
  { name: strings.map, icon: '', index: 5},
]

class WikiScreen extends React.PureComponent {
  render() {
    return (
      <GridView itemDimension={160} items={WikiList} renderItem={item => <WikiCell data={item}/>} />
    )
  }
}

export {WikiScreen};