import React, { Component } from 'react';
import { Text, StyleSheet, Image, ScrollView, FlatList, Alert } from 'react-native';
import { View } from 'react-native-animatable';
import { WoWsProgress, WoWsTouchable } from '../../component';
import language from '../../constant/language';
import { Blue, Orange, Grey } from 'react-native-material-color';
import { ShipDetailedInfo } from '../../core';
import { getTextColour } from '../../constant/colour';

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
      this.setState({data: data, isReady: true});
    })
  }

  render() {
    const { tier, name, ship_id, icon } = this.props.info;
    const { basicViewStyle, imageStyle } = styles;    
    const { data, isReady } = this.state;
    const { status, description } = data;
    if (isReady) { return (
      <ScrollView showsVerticalScrollIndicator={false}>  
        <View animation='fadeInRight' ref='mainView'>
          { this.renderBasic() }
          { this.getStatus() }
          { this.renderUpgrade() }
          { this.renderNextShip() }
        </View>
      </ScrollView>
    )} else { return (
      <View style={basicViewStyle}>
        {data_saver ? null : <Image source={{uri: icon, cache: 'default'}} style={imageStyle} resizeMode='contain'/>}
        <Text>{Tier[tier - 1] + ' ' + name}</Text>
      </View>
    )}
  }

  /**
   * Render section title
   * @param {*} text 
   */
  renderTitle(text) {
    return (
      <Text style={[styles.titleTextStyle, {backgroundColor: theme[500], color: getTextColour(theme[500])}]}>{text}</Text>      
    )
  }

  /**
   * Render basic information for warship
   */
  renderBasic() {
    const { basicViewStyle, imageStyle, descriptionStyle, tierTextStyle, basicTextStyle } = styles;
    const { tier, name, icon, nation, type } = this.props.info;
    const { description, price_credit, price_gold, is_premium, is_special } = this.state.data; 
    const { encyclopedia, ship_type } = global.data;
    return (
      <View style={basicViewStyle}>
        {data_saver ? null : <Image source={{uri: icon, cache: 'default'}} style={imageStyle} resizeMode='contain'/>}
        <Text style={tierTextStyle}>{Tier[tier - 1] + ' ' + name}</Text>
        <Text style={basicTextStyle}>{encyclopedia.ship_nations[nation] + '\n' + ship_type[type]}</Text>
        <Text style={[basicTextStyle, {color: is_premium ? Orange : Grey}]}>{is_premium ? price_gold : price_credit}</Text>  
        <Text style={descriptionStyle}>{description}</Text>
      </View>
    )
  }

  /**
   * Get general status for warship
   */
  getStatus() {  
    const { mobility, weaponry, concealment, armour } = this.state.data.default_profile;
    const { anti_aircraft, aircraft, artillery, torpedoes } = weaponry;
    const tintColor = theme[500] == '#ffffff' ? Blue : theme[500];    
    return (
      <View>
        { this.renderTitle(language.detail_status_title) }
        <WoWsProgress color={tintColor} value={armour.total} title={language.detail_survivability}/>
        <WoWsProgress color={tintColor} value={artillery} title={language.detail_artillery}/>
        <WoWsProgress color={tintColor} value={torpedoes} title={language.detail_torpedoes}/>
        <WoWsProgress color={tintColor} value={anti_aircraft} title={language.detail_aa}/>
        <WoWsProgress color={tintColor} value={mobility.total} title={language.detail_maneuverabilty}/>
        <WoWsProgress color={tintColor} value={concealment.total} title={language.detail_concealment}/>
        <WoWsProgress color={tintColor} value={aircraft} title={language.detail_aircraft}/>
      </View>
    )
  }

  /**
   * Render upgrade list
   */
  renderUpgrade() {
    const { mod_slots, upgrades } = this.state.data;
    upgradeKey = (value, index) => index;
    return (
      <View>
        { this.renderTitle(language.detail_upgrade_title + ' (' + mod_slots + ')') }
        <FlatList keyExtractor={upgradeKey} showsHorizontalScrollIndicator={false} horizontal data={upgrades} renderItem={({item}) => {
          let curr = data.consumable[item];
          return (
          <WoWsTouchable onPress={() => Alert.alert(curr.name, '\n' + curr.text, [{text: String(curr.price_credit)}])}>
            <View><Image style={{width: 64, height: 64}} source={{uri: curr.icon}}/></View>
          </WoWsTouchable>
        )}}/>
      </View>
    )
  }

  /**
   * Render next ship
   */
  renderNextShip() {
    const { next_ships } = this.state.data;
    if (Object.keys(next_ships).length == 0) return null;
    else {
      // Get all ships from next_ships
      var ships = []; for (key in next_ships) ships.push({key: key, exp: next_ships[key]});
      return (
        <View>
          { this.renderTitle(language.detail_next_ship_title) }
          { ships.map(function(value, index) {
            let curr = data.warship[value.key];
            return (
              <View>
                <Image source={{uri: curr.icon}} style={{width: 128, height: 128}} resizeMode='contain'/>
                <Text>{curr.name}</Text>
              </View>
            )
          })}
        </View>
      )
    }
  }
}

const styles = StyleSheet.create({
  mainViewStyle: {
    
  },
  titleTextStyle: {
    fontSize: 32, textAlign: 'center',
    fontWeight: '500', margin: 4, height: 40
  },
  tierTextStyle: {
    fontSize: 24, marginBottom: 4
  },
  basicTextStyle: {
    textAlign: 'center',
  },
  descriptionStyle: {
    padding: 4, fontWeight: '300', textAlign: 'center', 
    marginTop: 8, marginBottom: 8
  },
  basicViewStyle: {
    alignItems: 'center'
  },
  imageStyle: {
    height: 128,
    width: 192
  }
})