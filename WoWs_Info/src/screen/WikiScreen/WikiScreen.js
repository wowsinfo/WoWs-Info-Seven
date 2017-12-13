import React from 'react';
import GridView from 'react-native-super-grid';
import { WikiCell } from '../../component';
import strings from '../../localization';
import { View, FlatList } from 'react-native'; 

const WikiList = [{ name: strings.achievement, icon: '', index: 0}, 
  { name: strings.flag_camouflage, icon: '', index: 1},
  { name: strings.warship, icon: '', index: 2},  
  { name: strings.commander, icon: '', index: 3},
  { name: strings.upgrade, icon: '', index: 4},
  { name: strings.map, icon: '', index: 5}]

class WikiScreen extends React.PureComponent {
  keyExtractor = (item) => {return item.name}  
  render() {
    return (
      <View style={{flex: 1}}>
        <FlatList style={{}} data={WikiList} keyExtractor={this.keyExtractor} 
            renderItem={({item}) => <WikiCell data={item}/>} />
      </View>
    )
  }
}

export {WikiScreen};