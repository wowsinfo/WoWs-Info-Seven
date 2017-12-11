import React from 'react';
import { Text } from 'react-native';
import GridView from 'react-native-super-grid';
import { Actions } from 'react-native-router-flux';
import { WikiCell } from '../../component';

const WikiList = [
  { name: 'Achievement', icon: ''},
  { name: 'Flag/Camouflage', icon: ''},
  { name: 'Upgrade', icon: ''},
  { name: 'Commander', icon: ''},
  { name: 'Warship', icon: ''},
  { name: 'Map', icon: ''},
]

class WikiScreen extends React.PureComponent {
  render() {
    return (
      <GridView itemDimension={128} items={WikiList} renderItem={item => <WikiCell data={item}/>} />
    )
  }
}

export {WikiScreen};