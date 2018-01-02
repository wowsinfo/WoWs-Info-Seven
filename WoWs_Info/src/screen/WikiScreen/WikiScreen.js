import React from 'react';
import GridView from 'react-native-super-grid';
import { WikiCell } from '../../component';
import strings from '../../localization';
import { View, FlatList } from 'react-native'; 

class WikiScreen extends React.PureComponent {
  componentWillMount() {
    this.WikiList = [{ name: strings.achievement, icon: require('../../img/Achievement.png'), index: 0}, 
    { name: strings.flag_camouflage, icon: require('../../img/FlagCamouflage.png'), index: 1},
    { name: strings.warship, icon: require('../../img/LogoWhite.png'), index: 2},  
    { name: strings.commander, icon: require('../../img/CommanderSkill.png'), index: 3},
    { name: strings.upgrade, icon: require('../../img/Upgrade.png'), index: 4},
    { name: strings.map, icon: require('../../img/Map.png'), index: 5},
    { name: strings.collection, icon: require('../../img/Collection.png'), index: 6}];
  }

  keyExtractor = (item) => {return item.name}  
  render() {
    return (
      <View style={{flex: 1}}>
        <FlatList data={this.WikiList} keyExtractor={this.keyExtractor} numColumns={2}
          renderItem={({item}) => <WikiCell data={item}/>} />
      </View>
    )
  }
}

export {WikiScreen};