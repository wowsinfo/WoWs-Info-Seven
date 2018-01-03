import React from 'react';
import { View, Text, Image } from 'react-native';
import { WoWsTouchable } from '../../component';
import { PersonalRating, ShipManager } from '../../core';
import { Actions } from 'react-native-router-flux';
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
    this.tierName = tierList[shipInfo.tier - 1] + ' ' + shipInfo.name;
    return (
      <View style={[mainViewStyle, {borderColor: shipColour}]}>
        <WoWsTouchable onPress={this.gotoShipDetail}>
          <View>
            <View style={subViewStyle}>
              <Image resizeMode='contain' source={shipType} style={[imageStyle, {tintColor: global.themeColour}]}/>
              <Text style={textStyle}>{this.tierName}</Text>
            </View>
            <Info3Cell info={{battle: battle, winrate: win_rate, damage: avg_damage}}/>
          </View>
        </WoWsTouchable>
      </View>
    )
  }

  gotoShipDetail = () => {
    const { info } = this.props;
    Actions.ShipDetailScreen({title: info.ship_id, info: info})
  }

  getShipInfo(id) {
    let shipInfo = {};    
    let ship = global.warshipJson[id];
    if (ship != null) {
      shipInfo.name = ship.name;
      shipInfo.image = ship.icon;
      shipInfo.type = ship.type;
      shipInfo.tier = ship.tier;
      shipInfo.nation = ship.nation;
    }
    return shipInfo;    
  }
}

export {ShipInfoCell};