import React from 'react';
import { View, Text, Image, ScrollView } from 'react-native';
import { Divider } from 'react-native-elements';
import { PersonalRating } from '../../core';
import { styles } from './ShipDetailScreenStyles';
import { Basic8Cell } from '../../component';
import strings from '../../localization';

class ShipDetailScreen extends React.PureComponent {
  render() {
    const { mainViewStyle, scrollViewStyle, shipNameStyle, ratingStyle } = styles;
    const { index, ship_id } = this.props.info;
    let shipColour = PersonalRating.getColour(index);
    let shipComment = PersonalRating.getComment(index);
    let shipInfo = this.getShipInfo(ship_id);
    return (
      <View style={mainViewStyle}>
        <ScrollView>
          { this.renderImage(shipInfo, ship_id) }
          <Text style={shipNameStyle}>{shipInfo.name}</Text>
          <Text style={[ratingStyle, {color: shipColour}]}>{shipComment}</Text>
          <Basic8Cell info={this.getBasic8CellInfo(this.props.info)}/>
          <Divider style={{height: 1.5, backgroundColor: global.themeColour}}/>
          { this.renderDetailInfo(this.props.info) }
        </ScrollView>
      </View>
    )
  }

  renderImage(info, id) {
    if (id == 4183701200) {
      return <Image source={require('../../img/fubuki.jpg')} style={{width: 200, height: 255, alignSelf: 'center'}}/>
    } else {
      return <Image source={{uri: info.image}} style={styles.imageStyle}/>
    }
  }

  getShipInfo(id) {
    let ship = global.warshipJson[id];
    var shipInfo = {name: strings.deleted_ships, image: ''};
    if (ship != null) {
      shipInfo.name = ship.name;
      shipInfo.image = ship.icon;
    }
    return shipInfo;
  }

  getBasic8CellInfo(info) {
    var basicInfo = {};
    let battle = info.battle
    basicInfo.battle = battle;
    basicInfo.winrate = info.win_rate;
    basicInfo.damage = info.avg_damage;
    basicInfo.exp = Math.round(info.pvp.xp / battle);
    basicInfo.hitratio = Math.round(info.pvp.main_battery.hits * 10000 / info.pvp.main_battery.shots) / 100;
    basicInfo.survival = Math.round(info.pvp.survived_battles * 10000 / battle) / 100;
    let death = battle - info.pvp.survived_battles;
    basicInfo.killdeath = Math.round(info.pvp.frags * 100 / death) / 100;
    basicInfo.frag = Math.round(info.pvp.frags * 100 / battle) / 100;
    return basicInfo;
  }

  renderDetailInfo(info) {
    console.log(info);
    var detailInfo = [];
    let pvp = info.pvp;
    let titleList = [strings.max_damage, strings.max_exp, strings.max_kill, strings.max_plane];
    let dataList = [pvp.max_damage_dealt, pvp.max_xp, pvp.max_frags_battle, pvp.max_planes_killed];  
    for (var i = 0; i < titleList.length; i++) {
      let curr = dataList[i];
      if (curr > 0) {
        // Ignore it if it is zero!
        var data = {};        
        data.title = titleList[i];
        data.number = curr;
        detailInfo.push(data);
      }
    }  
    let weaponTitleList = [strings.max_main_battery, strings.max_secondary, strings.max_torpedo, strings.max_ramming, strings.max_aircraft];
    let weaponList = [pvp.main_battery, pvp.second_battery, pvp.torpedoes, pvp.ramming, pvp.aircraft];
    for (var i = 0; i < weaponTitleList.length; i++) {
      let curr = weaponList[i].frags;
      if (curr > 0) {
        // Ignore it if it is zero!
      var data = {};        
        data.title = weaponTitleList[i];
        data.number = curr;
        detailInfo.push(data);
      }
    }
    
    const { numberStyle, titleStyle, recordViewStyle } = styles;
    return detailInfo.map((data, i) => {
      return (
        <View style={recordViewStyle} key={i}>
          <Text style={titleStyle}>{data.title}</Text>
          <Text style={numberStyle}>{data.number}</Text>
        </View>
      )
    })
  }
}

export {ShipDetailScreen};