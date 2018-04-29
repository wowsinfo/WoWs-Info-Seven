import React, { Component } from 'react';
import { View, Text, StyleSheet, Image, ScrollView } from 'react-native';
import { WoWsProgress } from '../../component';
import language from '../../constant/language';
import { Blue } from 'react-native-material-color';
import { ShipDetailedInfo } from '../../core';

const Tier = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];
export default class ShipDetail extends Component {
  constructor(props) {
    super(props);
    this.state = {data: {}, isReady: false};
  }

  componentWillMount() {
    ShipDetailedInfo.getDefault(this.props.info.ship_id).then(data => {
      var parsed = {};
      // Get almost everything from data
      const { default_profile, description, is_premium, is_special, mod_slot, price_credit, price_gold, upgrades, next_ships, modules_tree } = data;
      const { engine, torpedo_bomber, anti_aircraft, mobility, hull, atbas, artillery, torpedoes, fighters, fire_control, 
        weaponry, battle_level_range_max, battle_level_range_min, flight_control, concealment, armour, dive_bomber } = default_profile;
      // Ship description
      parsed.description = description;
      // Collect status from everywhere
      parsed.status = this.getStatus(mobility, weaponry, concealment, armour);
      this.setState({data: parsed, isReady: true});
    })
  }

  /**
   * Get general status for warship
   * @param {*} mobility 
   * @param {*} weaponry 
   * @param {*} concealment 
   * @param {*} armour 
   */
  getStatus(mobility, weaponry, concealment, armour) {
    const { anti_aircraft, aircraft, artillery, torpedoes } = weaponry;
    return {aa: anti_aircraft, aircraft: aircraft, gun: artillery, torp: torpedoes, 
      concealment: concealment.total, armour: armour.total, mobility: mobility.total};
  }

  render() {
    const { tier, name, ship_id, icon } = this.props.info;
    const { mainViewStyle, basicViewStyle, imageStyle, titleTextStyle, descriptionStyle } = styles;
    
    const { data, isReady } = this.state;
    const { status, description } = data;

    var tintColor = theme[500] == '#ffffff' ? Blue : theme[500];
    if (isReady) { return (
      <ScrollView>
        { /* Ship icon, name, tier, nation and price */ }        
        <View style={basicViewStyle}>
          {data_saver ? null : <Image source={{uri: icon, cache: 'default'}} style={imageStyle} resizeMode='contain'/>}
          <Text>{Tier[tier - 1] + ' ' + name}</Text>
          <Text style={descriptionStyle}>{description}</Text>
        </View>
        { /* Status with many progress */ }
        <View>
          <Text style={titleTextStyle}>{language.detail_status_title}</Text>
          <WoWsProgress color={tintColor} value={status.armour} title={language.detail_survivability}/>
          <WoWsProgress color={tintColor} value={status.gun} title={language.detail_artillery}/>
          <WoWsProgress color={tintColor} value={status.torp} title={language.detail_torpedoes}/>
          <WoWsProgress color={tintColor} value={status.aa} title={language.detail_aa}/>
          <WoWsProgress color={tintColor} value={status.mobility} title={language.detail_maneuverabilty}/>
          <WoWsProgress color={tintColor} value={status.concealment} title={language.detail_concealment}/>
          <WoWsProgress color={tintColor} value={status.aircraft} title={language.detail_aircraft}/>
        </View>
      </ScrollView>
    )} else { return (
      <View style={basicViewStyle}>
        {data_saver ? null : <Image source={{uri: icon, cache: 'default'}} style={imageStyle} resizeMode='contain'/>}
        <Text>{Tier[tier - 1] + ' ' + name}</Text>
      </View>
    )}
  }
}

const styles = StyleSheet.create({
  mainViewStyle: {
    
  },
  titleTextStyle: {
    fontSize: 32, textAlign: 'center',
    fontWeight: '500', padding: 8
  },
  descriptionStyle: {
    padding: 4, fontWeight: '300', textAlign: 'center'
  },
  basicViewStyle: {
    alignItems: 'center'
  },
  imageStyle: {
    height: 128,
    width: 192
  }
})