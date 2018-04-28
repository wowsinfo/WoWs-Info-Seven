import React from 'react';
import { View } from 'react-native'
import { DrawerCell } from '../../component';

export default Wiki = () => {
  return (
    <View>
      <DrawerCell icon={require('../../img/Achievement.png')} title={language.wiki_achievement}/>
      <DrawerCell icon={require('../../img/Warship.png')} title={language.wiki_warship}/>
      <DrawerCell icon={require('../../img/Upgrade.png')} title={language.wiki_upgrade}/>
      <DrawerCell icon={require('../../img/Camouflage.png')} title={language.wiki_flag_camouflage}/>
      <DrawerCell icon={require('../../img/Commander.png')} title={language.wiki_commander}/>
      <DrawerCell icon={require('../../img/Map.png')} title={language.wiki_map}/>
      <DrawerCell icon={require('../../img/Collection.png')} title={language.wiki_collection}/>
    </View>
  )
}