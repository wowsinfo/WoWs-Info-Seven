import React, { Component } from 'react';
import { Text, StyleSheet, Image, ScrollView, FlatList, Alert } from 'react-native';
import { View } from 'react-native-animatable';
import ElevatedView from 'react-native-elevated-view';
import { WoWsProgress, WoWsTouchable, WoWsLoading } from '../../component';
import language from '../../constant/language';
import { Orange, Grey } from 'react-native-material-color';
import { ShipDetailedInfo } from '../../core';
import { navStyle, getTheme } from '../../constant/colour';
import { Divider } from 'react-native-elements';

const Tier = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];
export default class ShipDetail extends Component {
  constructor(props) {
    super(props);
    this.state = {data: {}, isReady: false, profile: {}};
  }

  static navigatorStyle = {
    tabBarHidden: true
  }

  componentWillMount() {
    ShipDetailedInfo.getDefault(this.props.info.ship_id).then(data => {
      // Get almost everything from data
      const { default_profile, description, is_premium, is_special, mod_slot, price_credit, price_gold, upgrades, next_ships, modules_tree } = data;
      const { engine, torpedo_bomber, anti_aircraft, mobility, hull, atbas, artillery, torpedoes, fighters, fire_control, 
        weaponry, battle_level_range_max, battle_level_range_min, flight_control, concealment, armour, dive_bomber } = default_profile;
      for (module in modules_tree) {
        let curr = modules_tree[module];
        if (curr.next_modules != null) console.log(curr);
      }
      // Collect status from everywhere
      this.setState({data: data, isReady: true, profile: data.default_profile});
    })
  }

  render() {
    if (this.state.isReady) { return (
      <ScrollView>  
        <View animation='fadeInUp' ref='mainView'>
          { this.renderBasic() }
          { this.getStatus() }
          { this.renderSurvivability() }
          { this.renderMainBattery() }
          { this.renderSecondary() }
          { /*this.renderAircraft()*/ }
          { this.renderTorpedo() }
          { this.renderAADefense() }
          { this.renderConcealment() }
          { this.renderMobility() }
          { this.renderUpgrade() }
          { this.renderNextShip() }
        </View>
      </ScrollView>
    )} else return <WoWsLoading />
  }

  /**
   * Render section title
   * @param {*} text 
   */
  renderTitle(text) {
    let textColor = getTheme();
    return (
      <View>
        <Text style={[styles.titleTextStyle, {color: textColor}]}>{text}</Text>
      </View>
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
    return (
      <ElevatedView elevation={2} style={[basicViewStyle, {margin: 8}]}>
        {data_saver ? null : <Image source={{uri: icon, cache: 'default'}} style={imageStyle} resizeMode='contain'/>}
        <Text style={tierTextStyle}>{Tier[tier - 1] + ' ' + name}</Text>
        <Text style={basicTextStyle}>{encyclopedia.ship_nations[nation] + '\n' + ship_type[type]}</Text>
        <Text style={[basicTextStyle, {color: isPremium ? Orange : Grey}]}>{isPremium ? price_gold : price_credit}</Text> 
        <Text style={descriptionStyle}>{description}</Text>
      </ElevatedView>
    )
  }

  /**
   * Get general status for warship
   */
  getStatus() {  
    const { mobility, weaponry, concealment, armour } = this.state.profile
    const { anti_aircraft, aircraft, artillery, torpedoes } = weaponry;

    // White -> Blue
    const tintColor = getTheme();
    return (
      <ElevatedView elevation={2} style={{margin: 8}}>
        { this.renderTitle(language.detail_status_title) }
        <WoWsProgress color={tintColor} value={armour.total} title={language.detail_survivability}/>
        <WoWsProgress color={tintColor} value={artillery} title={language.detail_artillery}/>
        <WoWsProgress color={tintColor} value={torpedoes} title={language.detail_torpedoes}/>
        <WoWsProgress color={tintColor} value={anti_aircraft} title={language.detail_aa}/>
        <WoWsProgress color={tintColor} value={mobility.total} title={language.detail_maneuverabilty}/>
        <WoWsProgress color={tintColor} value={concealment.total} title={language.detail_concealment}/>
        <WoWsProgress color={tintColor} value={aircraft} title={language.detail_aircraft}/>
      </ElevatedView>
    )
  }

  /**
   * Render information about health, armour
   */
  renderSurvivability() {
    const { flood_prob, range, health } = this.state.data.default_profile.armour;
    const { horizontalViewStyle, basicTextStyle, basicTitleStyle, basicViewStyle } = styles;
    return (
      <ElevatedView elevation={2} style={{margin: 8}}>
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
      </ElevatedView>
    )
  }

  /**
   * Render main battery and secondary information
   */
  renderMainBattery() {
    const { horizontalViewStyle, basicTextStyle, basicTitleStyle } = styles;
    const { artillery } = this.state.profile
    if (artillery != null) {
      const { max_dispersion, gun_rate, distance, rotation_time, slots, shells } = artillery;
      const { AP, HE } = shells;
      // Get all guns
      var mainGun = '', gunName = '';
      for (gun in slots) mainGun += slots[gun].guns + ' x ' + slots[gun].barrels + '  '; gunName = slots[gun].name;
      // Get gun penetration
      let calibar = Math.round(parseInt(gunName.split(' ')[0]) / 6);

      return (
        <ElevatedView elevation={2} style={{margin: 8}}>
          { artillery == null ? null : <View>
            { this.renderTitle(language.artillery_main) }
            <View style={horizontalViewStyle}>
              <Text>{Number(60 / gun_rate).toFixed(1) + ' s'}</Text> 
              <Text>{Number(distance).toFixed(2) + ' km'}</Text> 
              <Text>{mainGun}</Text> 
            </View>
            <Text style={basicTitleStyle}>{gunName}</Text>            
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
        </ElevatedView>
      )
    } else return null;
  }

  /**
   * Render secondary information
   */
  renderSecondary() {
    const { horizontalViewStyle, basicTextStyle, basicTitleStyle, basicViewStyle } = styles;
    const { atbas } = this.state.profile
    if (atbas != null) {
      const { distance, slots } = atbas;
      var guns = []; for (gun in slots) guns.push(slots[gun]);
      return (
        <ElevatedView elevation={2} style={{margin: 8}}>
          { this.renderTitle(language.artillery_secondary + ' (' + distance + ' km)') }
          { guns.map(function(value, index) { 
            const { burn_probability, bullet_speed, name, gun_rate, damage, type } = value;            
            return (
              <View key={index} style={basicViewStyle}>
                <Text style={basicTitleStyle}>{type + ' - ' + name}</Text>
                <View style={horizontalViewStyle}>
                  <Text style={basicTextStyle}>{Number(60 / gun_rate).toFixed(1) + ' s'}</Text>
                  <Text style={basicTextStyle}>{bullet_speed + ' m/s'}</Text>
                  { burn_probability == null ? null : <Text style={basicTextStyle}>{'🔥'+ burn_probability + '%'}</Text> }
                  <Text style={basicTextStyle}>{damage}</Text>
                </View>
              </View>
          )})}
        </ElevatedView>
      )
    } else return null;
  }

  /**
   * Render aircraft information
   */
  renderAircraft() {
    const { basicTextStyle } = styles;
    const { flight_control } = this.state.profile;
    if (flight_control != null) {
      const { fighter_squadrons, torpedo_squadrons, bomber_squadrons } = flight_control;
      return (
        <ElevatedView elevation={2} style={{margin: 8}}>
          { this.renderTitle(language.detail_aircraft) }
          { this.renderFighter() }
          { this.renderTorpedoBomber() }
          { this.renderBomber() }
          <Text style={basicTextStyle}>{fighter_squadrons + ' - ' + torpedo_squadrons + ' - ' + bomber_squadrons}</Text>
        </ElevatedView>
      )
    } else return null;
  }

  renderFighter() {
    const { horizontalViewStyle, basicTextStyle, basicTitleStyle, basicViewStyle } = styles;
    const { fighters } = this.state.profile;
    if (fighters != null) {
      const {} = fighters;
      return (
        <ElevatedView elevation={2} style={{margin: 8}}>
          <Text style={basicTitleStyle}>{language.aircraft_fighter}</Text>
        </ElevatedView>
      )
    } else return null;
  }

  renderTorpedoBomber() {
    const { horizontalViewStyle, basicTextStyle, basicTitleStyle, basicViewStyle } = styles;
    const { torpedo_bomber } = this.state.profile;
    if (torpedo_bomber != null) {
      return (
        <ElevatedView elevation={2} style={{margin: 8}}>
          <Text style={basicTitleStyle}>{language.aircraft_torpedo_bomber}</Text>
        </ElevatedView>
      )
    } else return null;
  }
  
  renderBomber() {
    const { horizontalViewStyle, basicTextStyle, basicTitleStyle, basicViewStyle } = styles;
    const { dive_bomber } = this.state.profile;
    if (dive_bomber != null) {
      return (
        <ElevatedView elevation={2} style={{margin: 8}}>
          <Text style={basicTitleStyle}>{language.aircraft_bomber}</Text>
        </ElevatedView>
      )
    } else return null;
  }

  /**
   * Render torpedo information
   */
  renderTorpedo() {
    const { horizontalViewStyle, basicTextStyle, basicTitleStyle } = styles;
    const { torpedoes } = this.state.profile;
    if (torpedoes != null) {
      const { visibility_dist, distance, torpedo_name, reload_time, torpedo_speed, slots, max_damage } = torpedoes;
      var torps = ''; for (torp in slots) torps += slots[torp].guns + ' x ' + slots[torp].barrels + '  ';
      return (
        <ElevatedView elevation={2} style={{margin: 8}}>
          { this.renderTitle(language.detail_torpedoes) }
          <View style={horizontalViewStyle}>
            <Text>{reload_time + ' s'}</Text>
            <Text>{distance + ' km'}</Text>
            <Text>{torps}</Text>
          </View>
          <Text style={basicTitleStyle}>{torpedo_name + ' (' + Number(visibility_dist * 1000 / 2.6 / torpedo_speed).toFixed(1) + ' s)'}</Text>
          <View style={horizontalViewStyle}>
            <Text>{visibility_dist + ' km'}</Text>
            <Text>{max_damage}</Text>
            <Text>{torpedo_speed + ' kt'}</Text>
          </View>
        </ElevatedView>
      )
    } else return null;
  }

  /**
   * Render aa defense information
   */
  renderAADefense() {
    const { horizontalViewStyle, basicTextStyle, basicTitleStyle, basicViewStyle } = styles;
    const { anti_aircraft } = this.state.profile;
    if (anti_aircraft != null) {
      const { slots } = anti_aircraft;
      var AAValues = []; for (aa in slots) AAValues.push(slots[aa]);
      return (
        <ElevatedView elevation={2} style={{margin: 8}}>
          { this.renderTitle(language.detail_aa) }
          { AAValues.map(function(value, index) {
            const { distance, avg_damage, name, guns } = value;
            return (
              <View key={index} style={basicViewStyle}>
                <Text style={basicTitleStyle}>{name}</Text>
                <View style={horizontalViewStyle}>
                  <Text style={basicTextStyle}>{guns + 'x'}</Text>                  
                  <Text style={basicTextStyle}>{distance + ' km'}</Text>
                  <Text style={basicTextStyle}>{avg_damage + ' dps'}</Text>
                </View>
              </View>
            )
          })}
        </ElevatedView>
      )
    } else return null;
  }

  /**
   * Render mobility information
   */
  renderMobility() {
    const { horizontalViewStyle, basicTextStyle } = styles;
    const { rudder_time, turning_radius, max_speed } = this.state.profile.mobility
    return (
      <ElevatedView elevation={2} style={{margin: 8}}>
        { this.renderTitle(language.detail_maneuverabilty) }
        <View style={horizontalViewStyle}>
          <Text style={basicTextStyle}>{rudder_time + ' s'}</Text>
          <Text style={basicTextStyle}>{max_speed + ' kt'}</Text>
          <Text style={basicTextStyle}>{turning_radius + ' m'}</Text>
        </View>
      </ElevatedView>
    )
  }

  /**
   * Render concealment information
   */
  renderConcealment() {
    const { horizontalViewStyle, basicTextStyle, basicViewStyle, basicTitleStyle } = styles;
    const { detect_distance_by_plane, detect_distance_by_ship } = this.state.profile.concealment
    return (
      <ElevatedView elevation={2} style={{margin: 8}}>
        { this.renderTitle(language.detail_concealment) }
        <View style={horizontalViewStyle}>
          <View style={basicViewStyle}>
            <Text style={basicTitleStyle}>{language.concealment_plane}</Text>
            <Text style={basicTextStyle}>{detect_distance_by_plane + ' km'}</Text>
          </View>
          <View style={basicViewStyle}>
            <Text style={basicTitleStyle}>{language.concealment_ship}</Text>
            <Text style={basicTextStyle}>{detect_distance_by_ship + ' km'}</Text>
          </View>
        </View>
      </ElevatedView>
    )
  }

  /**
   * Render upgrade list
   */
  renderUpgrade() {
    const { mod_slots, upgrades } = this.state.data;
    upgradeKey = (value, index) => String(index);
    return (
      <ElevatedView elevation={2} style={{margin: 8}}>
        { this.renderTitle(language.detail_upgrade_title + ' (' + mod_slots + ')') }
        <FlatList keyExtractor={upgradeKey} showsHorizontalScrollIndicator={false} horizontal data={upgrades} renderItem={({item}) => {
          let curr = data.consumable[item];
          return (
          <WoWsTouchable onPress={() => Alert.alert(curr.name, '\n' + curr.text, [{text: String(curr.price_credit)}])}>
            <View><Image style={{width: 64, height: 64}} source={{uri: curr.icon}}/></View>
          </WoWsTouchable>
        )}}/>
      </ElevatedView>
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
      shipKey = (value, index) => String(index);      
      return (
        <ElevatedView elevation={2} style={{margin: 8}}>
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
        </ElevatedView>
      )
    }
  }
}

const styles = StyleSheet.create({
  titleTextStyle: {
    textAlign: android ? 'left' : 'center', fontSize: 18,
    fontWeight: 'bold', padding: 8, paddingLeft: android ? 8 : 0
  },
  tierTextStyle: {
    fontSize: 24, marginBottom: 4
  },
  basicViewStyle: {
    flex: 1, paddingTop: 4, padding: 8, margin: 8
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