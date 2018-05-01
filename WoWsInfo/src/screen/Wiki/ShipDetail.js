import React, { Component } from 'react';
import { Text, StyleSheet, Image, ScrollView, FlatList, Alert } from 'react-native';
import { View } from 'react-native-animatable';
import { WoWsProgress, WoWsTouchable } from '../../component';
import language from '../../constant/language';
import { Blue, Orange, Grey } from 'react-native-material-color';
import { ShipDetailedInfo } from '../../core';
import { getTextColour, navStyle } from '../../constant/colour';

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
          { this.renderSurvivability() }
          { this.renderMainBattery() }
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
    const { basicViewStyle, imageStyle, descriptionStyle, tierTextStyle, basicTextStyle, horizontalViewStyle } = styles;
    const { tier, name, icon, nation, type } = this.props.info;
    const { description, price_credit, price_gold, is_premium, is_special, ship_id } = this.state.data; 
    const { encyclopedia, ship_type } = global.data;
    // Special or Premium
    const isPremium = is_premium || is_special;
    // Show avergae data
    const pr = data.personal_rating[ship_id];
    return (
      <View style={basicViewStyle}>
        {data_saver ? null : <Image source={{uri: icon, cache: 'default'}} style={imageStyle} resizeMode='contain'/>}
        <Text style={tierTextStyle}>{Tier[tier - 1] + ' ' + name}</Text>
        <Text style={basicTextStyle}>{encyclopedia.ship_nations[nation] + '\n' + ship_type[type]}</Text>
        <Text style={[basicTextStyle, {color: isPremium ? Orange : Grey}]}>{isPremium ? price_gold : price_credit}</Text> 
        { pr == null ? null : <View style={horizontalViewStyle}>
          <Text style={basicTextStyle}>{Number(pr.average_damage_dealt).toFixed(0)}</Text>
          <Text style={basicTextStyle}>{Number(pr.win_rate).toFixed(2) + '%'}</Text>
          <Text style={basicTextStyle}>{Number(pr.average_frags).toFixed(2)}</Text>
        </View>}
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

    // White -> Blue
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
   * Render information about health, armour
   */
  renderSurvivability() {
    const { flood_prob, range, health } = this.state.data.default_profile.armour;
    const { horizontalViewStyle, basicTextStyle, basicTitleStyle, basicViewStyle } = styles;
    return (
      <View >
        { this.renderTitle(language.detail_survivability) }
        <View style={horizontalViewStyle}>
          <View style={basicViewStyle}>
            <Text style={basicTitleStyle}>{language.survivability_health}</Text>
            <Text style={basicTextStyle}>{health}</Text>          
          </View>
          <View style={basicViewStyle}>
            <Text style={basicTitleStyle}>{language.survivability_armour}</Text>
            <Text style={basicTextStyle}>{range.max + 'mm - ' + range.min + 'mm'}</Text>
          </View>
          { flood_prob == 0 ? null : 
          <View style={basicViewStyle}>
            <Text style={basicTitleStyle}>{language.survivability_protection}</Text>
            <Text style={basicTextStyle}>{flood_prob + '%'}</Text>
          </View> }
        </View>
      </View>
    )
  }

  /**
   * Render main battery and secondary information
   */
  renderMainBattery() {
    const { horizontalViewStyle, basicTextStyle, basicTitleStyle } = styles;
    const { artillery } = this.state.data.default_profile;
    if (artillery != null) {
      const { max_dispersion, gun_rate, distance, rotation_time, slots, shells } = artillery;
      const { AP, HE } = shells;
      // Get all guns
      var mainGun = '', gunName = '';
      for (gun in slots) mainGun += slots[gun].guns + ' x ' + slots[gun].barrels + '  '; gunName = slots[gun].name;
      // Get gun penetration
      let calibar = Math.round(parseInt(gunName.split(' ')[0]) / 6);

      return (
        <View>
          { artillery == null ? null : <View>
            { this.renderTitle(language.artillery_main) }
            <View style={horizontalViewStyle}>
              <Text>{Number(60 / gun_rate).toFixed(1) + ' s'}</Text> 
              <Text>{Number(distance).toFixed(2) + ' km'}</Text> 
              <Text>{mainGun}</Text> 
            </View>
            <Text style={basicTextStyle}>{gunName}</Text>            
            <View style={[horizontalViewStyle, {paddingBottom: 8}]}>
              <Text>{max_dispersion + ' m'}</Text>
              <Text>{rotation_time + ' s'}</Text>
            </View>
            <View style={horizontalViewStyle}>
              { HE == null ? null : <View>
                <Text style={basicTitleStyle}>HE</Text>
                <Text style={basicTextStyle}>{'🔥' + HE.burn_probability + '%'}</Text> 
                <Text style={basicTextStyle}>{HE.bullet_mass + ' kg'}</Text>                
                <Text style={basicTextStyle}>{HE.damage + ' (' + calibar + ' mm)'}</Text> 
                <Text style={basicTextStyle}>{HE.bullet_speed + ' m/s'}</Text>
              </View>}
              { AP == null ? null : <View>
                <Text style={basicTitleStyle}>AP</Text>                
                <Text style={basicTextStyle}>-0-</Text> 
                <Text style={basicTextStyle}>{AP.bullet_mass + ' kg'}</Text> 
                <Text style={basicTextStyle}>{AP.damage}</Text> 
                <Text style={basicTextStyle}>{AP.bullet_speed + ' m/s'}</Text>
              </View>}
            </View>
          </View>}
        </View>
      )
    } else return null;
  }

  /**
   * Render upgrade list
   */
  renderUpgrade() {
    const { mod_slots, upgrades } = this.state.data;
    upgradeKey = (value, index) => String(index);
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
      shipKey = (value, index) => index;      
      return (
        <View>
          { this.renderTitle(language.detail_next_ship_title) }
          <FlatList data={ships} keyExtractor={shipKey} renderItem={({item}) => {  
            let curr = data.warship[item.key];
            return (
              <WoWsTouchable onPress={() => {
                this.props.navigator.pop();
                this.props.navigator.push({
                  screen: 'ship.detail',
                  title: '[' + curr.ship_id_str + '] ' + curr.ship_id,
                  passProps: {info: curr},
                  navigatorStyle: navStyle()
                })}}>
                <View style={{alignSelf: 'center'}}>
                  <Image source={{uri: curr.icon}} style={{width: 128, height: 64}} resizeMode='contain'/>
                  <Text style={{textAlign: 'center', fontWeight: 'bold'}}>{curr.name}</Text>
                </View>
              </WoWsTouchable>
            )}}/>
        </View>
      )
    }
  }
}

const styles = StyleSheet.create({
  mainViewStyle: {
    
  },
  titleTextStyle: {
    fontSize: 32, textAlign: android ? 'left' : 'center',
    fontWeight: '500', margin: 4, height: android ? 50: 40, marginTop: 16,
  },
  tierTextStyle: {
    fontSize: 24, marginBottom: 4
  },
  basicViewStyle: {
    flex: 1
  },
  basicTextStyle: {
    textAlign: 'center', margin: 2, fontWeight: '300', width: '100%', flex: 1
  },
  basicTitleStyle: {
    textAlign: 'center', fontSize: 16, fontWeight: 'bold', width: '100%', flex: 1
  },
  horizontalViewStyle: {
    justifyContent: 'space-around', flexDirection: 'row', alignItems: 'center', flex: 1
  },
  descriptionStyle: {
    padding: 4, fontWeight: '300', textAlign: 'center', 
    marginTop: 8, marginBottom: 8
  },
  basicViewStyle: {
    alignItems: 'center', flex: 1
  },
  imageStyle: {
    height: 128,
    width: 192
  }
})