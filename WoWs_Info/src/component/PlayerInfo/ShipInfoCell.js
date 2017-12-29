import React from 'react';
import { View, Text, Image } from 'react-native';
import { WoWsTouchable } from '../../component';
import { PersonalRating, ShipManager } from '../../core';
import { styles } from './ShipInfoCellStyles';
import { Info3Cell } from './Info3Cell';

class ShipInfoCell extends React.PureComponent {
  render() {
    const { ship_id, battle, avg_damage, win_rate, index } = this.props.info;
    const { mainViewStyle, subViewStyle, imageStyle, textStyle} = styles;
    let tierList = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];
    let shipInfo = this.getShipInfo(ship_id);
    let shipColour = PersonalRating.getColour(index);
    let shipType = ShipManager.getImage(shipInfo.type);
    this.tierName = tierList[shipInfo.tier - 1] + ' ';
    if (shipInfo.nation == 'japan' && global.apiLanguage.includes('zh')) {
      let alias = global.aliasJson[ship_id];
      // Might be null sometimes if kongzhong.net has not updated their name yet
      if (alias != null) {
        this.tierName += alias;
      } 
    } else this.tierName += shipInfo.name;
    return (
      <View style={[mainViewStyle, {borderColor: shipColour}]}>
        <WoWsTouchable>
          <View style={subViewStyle}>
            <Image resizeMode='contain' source={shipType} style={[imageStyle, {tintColor: global.themeColour}]}/>
            <Text style={textStyle}>{this.tierName}</Text>
          </View>
          <Info3Cell info={{battle: battle, winrate: win_rate, damage: avg_damage}}/>
        </WoWsTouchable>
      </View>
    )
  }

  getShipInfo(id) {
    let shipInfo = {};    
    let ship = global.warshipJson[id];
    if (ship != null) {
      shipInfo.name = ship.name;
      shipInfo.image = ship.images.small;
      shipInfo.type = ship.type;
      shipInfo.tier = ship.tier;
      shipInfo.nation = ship.nation;
    }
    return shipInfo;    
  }
}

export {ShipInfoCell};