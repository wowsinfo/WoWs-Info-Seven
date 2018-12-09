/**
 * WarshipDetail.js
 * 
 * 
 */

import React, { PureComponent } from 'react';
import { View, FlatList,Linking, ScrollView, StyleSheet } from 'react-native';
import { Text, Title, Subheading, Headline, Button, Surface, Paragraph, List, Divider } from 'react-native-paper';
import { WoWsInfo, WikiIcon, WarshipCell, LoadingModal, PriceLabel, LoadingIndicator, WarshipStat, InfoLabel } from '../../component';
import { SAVED, SERVER, LOCAL } from '../../value/data';
import lang from '../../value/lang';
import { SafeFetch, langStr, Guard } from '../../core';
import { WoWsAPI } from '../../value/api';

class WarshipDetail extends PureComponent {
  constructor(props) {
    super(props);

    this.server = SERVER[DATA[LOCAL.userServer]];

    let curr = props.item;
    console.log(curr);

    // Get all other same tier and same type ships
    let warship = DATA[SAVED.warship];
    let similar = Object.entries(warship).filter(s => {
      if (s[1].tier === curr.tier && s[1].type === curr.type) return true;
    });

    // Remove extra information (ship id)
    similar.forEach((s, i) => similar[i] = Object.assign(s[1]));
    console.log(similar);

    this.state = {
      curr: props.item,
      similar: similar,
      loading: true,
      data: {}
    };

    this.delayedRequest = null;
  }

  componentWillMount() {
    // Start loading data here
    this.efficientDataRequest(this.props.item.ship_id);
  }

  render() {
    const { curr, similar } = this.state;
    if (curr) {
      return (
        <WoWsInfo title={`${curr.ship_id_str} ${curr.ship_id}`}>
          <ScrollView style={{flex: 1}} showsVerticalScrollIndicator={false}>
            <WikiIcon warship item={curr} scale={3}/>
            { this.renderContent() }
          </ScrollView> 
          <Divider />
          { this.renderSimilar(similar) }
        </WoWsInfo>
      )
    } else {
      // Bug here
    }
  };

  renderContent() {
    const { curr, loading, data } = this.state;
    if (loading) {
      return <LoadingIndicator />
    } else {
      return (
       <View>
        { this.renderBasic(curr, data) }
        { this.renderAll(data) }
       </View>
      )
    }
  }

  renderBasic(curr, data) {
    const { container, shipTitle, centerText, modelBtn } = styles;
    const { name, model, type, nation } = curr;
    const { description } = data;

    return (
      <View style={container}>
        <Title style={shipTitle}>{name}</Title>
        <Text>{nation.toUpperCase()}</Text>
        <Text>{type}</Text>
        <PriceLabel item={data}/>
        { model ? <Button style={modelBtn} onPress={() => Linking.openURL(`https://sketchfab.com/models/${model}/embed?autostart=1&preload=1`)}>
          {lang.warship_model}
        </Button> : null }
        <Paragraph style={centerText}>{description}</Paragraph>
      </View>
    )
  }

  renderAll(curr) {
    const { default_profile, modules_tree, modules, next_ships } = curr;

    return (
      <View>
        { this.renderStatus(Guard(curr, 'default_profile', null)) }
        { this.renderSurvivability(Guard(curr, 'default_profile.armour', null)) }
        { this.renderMainBattery(Guard(curr, 'default_profile.artillery', null)) }
      </View>
    )
  }

  /**
   * Render ship overall status
   * @param {*} profile 
   */
  renderStatus(profile) {
    if (profile) return <WarshipStat profile={profile} />;
    else return null;
  }

  /**
   * Render information about health, armour
   */
  renderSurvivability(armour) {
    const { flood_prob, range, health } = armour;
    const { horizontal, centerText } = styles;
    return (
      <View style={{margin: 8}}>
        <Headline style={centerText}>{lang.warship_survivability}</Headline>
        <View style={horizontal}>
          <InfoLabel title={lang.warship_survivability_health} info={health}/>
          <InfoLabel title={lang.warship_survivability_armour} info={range.max + 'mm - ' + range.min + 'mm'}/>
          { flood_prob == 0 ? null : <InfoLabel title={lang.warship_survivability_protection} info={`${flood_prob}%`}/> }
        </View>
      </View>
    )
  }

  /**
   * Render main battery and secondary information
   */
  renderMainBattery(artillery) {
    if (artillery) {
      const { horizontal, centerText } = styles;
      const { max_dispersion, gun_rate, distance, rotation_time, slots, shells } = artillery;
      const { AP, HE } = shells;

      // Get all guns
      var mainGun = '', gunName = '';
      for (gun in slots) mainGun += slots[gun].guns + ' x ' + slots[gun].barrels + '  '; gunName = slots[gun].name;
      // Get gun penetration
      let calibar = Math.round(parseInt(gunName.split(' ')[0]) / 6);

      return (
        <View style={{margin: 8}}>
          <Headline style={centerText}>{lang.warship_artillery_main}</Headline>
          <View style={horizontal}>
            <InfoLabel title={lang.warship_artillery_main_reload} info={`${Number(60 / gun_rate).toFixed(1)} s`}/>
            <InfoLabel title={lang.warship_artillery_main_range} info={`${Number(distance).toFixed(2)} km`}/>
            <InfoLabel title={lang.warship_artillery_main_guns} info={mainGun}/>
          </View>
          <View style={horizontal}>
            <InfoLabel title={lang.warship_artillery_main_dispersion} info={`${max_dispersion} m`}/>
            <InfoLabel title={lang.warship_artillery_main_rotation} info={`${rotation_time} s`}/>
          </View>
          <Title style={centerText}>{gunName}</Title>            
          <View style={horizontal}>
            { HE == null ? null : <View>
              <Title style={centerText}>HE</Title>
              <InfoLabel title={lang.warship_artillery_main_fire_chance} info={`🔥${HE.burn_probability}%`}/>
              <InfoLabel title={lang.warship_artillery_main_weight} info={`${HE.bullet_mass} kg`}/>
              <InfoLabel title={lang.warship_artillery_main_damage} info={`${HE.damage} (${calibar} mm)`}/>
              <InfoLabel title={lang.warship_artillery_main_velocity} info={`${HE.bullet_speed} m/s`}/>
            </View> }
            { AP == null ? null : <View>
              <Title style={centerText}>AP</Title>          
              <InfoLabel title={lang.warship_artillery_main_fire_chance} info='---'/>
              <InfoLabel title={lang.warship_artillery_main_weight} info={`${AP.bullet_mass} kg`}/>
              <InfoLabel title={lang.warship_artillery_main_damage} info={`${AP.damage} (${calibar} mm)`}/>
              <InfoLabel title={lang.warship_artillery_main_velocity} info={`${AP.bullet_speed} m/s`}/>
            </View> }
          </View>
        </View>
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
        <View style={{margin: 8}}>
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
        </View>
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
        <View style={{margin: 8}}>
          { this.renderTitle(language.detail_aircraft) }
          { this.renderFighter() }
          { this.renderTorpedoBomber() }
          { this.renderBomber() }
          <Text style={basicTextStyle}>{fighter_squadrons + ' - ' + torpedo_squadrons + ' - ' + bomber_squadrons}</Text>
        </View>
      )
    } else return null;
  }

  renderFighter() {
    const { horizontalViewStyle, basicTextStyle, basicTitleStyle, basicViewStyle } = styles;
    const { fighters } = this.state.profile;
    if (fighters != null) {
      const {} = fighters;
      return (
        <View style={{margin: 8}}>
          <Text style={basicTitleStyle}>{language.aircraft_fighter}</Text>
        </View>
      )
    } else return null;
  }

  renderTorpedoBomber() {
    const { horizontalViewStyle, basicTextStyle, basicTitleStyle, basicViewStyle } = styles;
    const { torpedo_bomber } = this.state.profile;
    if (torpedo_bomber != null) {
      return (
        <View style={{margin: 8}}>
          <Text style={basicTitleStyle}>{language.aircraft_torpedo_bomber}</Text>
        </View>
      )
    } else return null;
  }
  
  renderBomber() {
    const { horizontalViewStyle, basicTextStyle, basicTitleStyle, basicViewStyle } = styles;
    const { dive_bomber } = this.state.profile;
    if (dive_bomber != null) {
      return (
        <View style={{margin: 8}}>
          <Text style={basicTitleStyle}>{language.aircraft_bomber}</Text>
        </View>
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
        <View style={{margin: 8}}>
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
        </View>
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
        <View style={{margin: 8}}>
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
        </View>
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
      <View style={{margin: 8}}>
        { this.renderTitle(language.detail_maneuverabilty) }
        <View style={horizontalViewStyle}>
          <Text style={basicTextStyle}>{rudder_time + ' s'}</Text>
          <Text style={basicTextStyle}>{max_speed + ' kt'}</Text>
          <Text style={basicTextStyle}>{turning_radius + ' m'}</Text>
        </View>
      </View>
    )
  }

  /**
   * Render concealment information
   */
  renderConcealment() {
    const { horizontalViewStyle, basicTextStyle, basicViewStyle, basicTitleStyle } = styles;
    const { detect_distance_by_plane, detect_distance_by_ship } = this.state.profile.concealment
    return (
      <View style={{margin: 8}}>
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
      </View>
    )
  }

  /**
   * Render upgrade list
   */
  renderUpgrade() {
    const { mod_slots, upgrades } = this.state.data;
    upgradeKey = (value, index) => String(index);
    return (
      <View style={{margin: 8}}>
        { this.renderTitle(language.detail_upgrade_title + ' (' + mod_slots + ')') }
        <FlatList keyExtractor={upgradeKey} horizontal data={upgrades} renderItem={({item}) => {
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
      shipKey = (value, index) => String(index);      
      return (
        <View style={{margin: 8}}>
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

  /**
   * Do not render when there are no similar ships...
   * @param {*} similar 
   */
  renderSimilar(similar) {
    const { curr } = this.state;
    if (Object.keys(similar).length > 0) {
      return (
        <View style={{height: 86}}>
          <FlatList keyExtractor={item => item.name} horizontal data={similar} renderItem={({item}) => {
            return <WarshipCell item={item} scale={1.4} onPress={() => {
              this.setState({curr: item, loading: true}, 
                () => this.efficientDataRequest(item.ship_id));
            }}/>
          }} showsHorizontalScrollIndicator={false}/>
        </View>
      )
    } else return null;
  }

  efficientDataRequest(id) {
    clearTimeout(this.delayedRequest);
    // This will not work if you device time is faster than actual time
    this.delayedRequest = setTimeout(() => {
      SafeFetch.get(WoWsAPI.ShipWiki, this.server, id, langStr()).then(json => {
        let data = Guard(json, 'data', {});
        console.log(data);
        this.setState({data: data[id], loading: false});
      });
    }, 1000);
  }
}

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center'
  },
  shipTitle: {
    fontSize: 24,
    paddingBottom: 16
  },
  modelBtn: {
    marginTop: 8
  },
  centerText: {
    textAlign: 'center',
  },
  horizontal: {
    flexDirection: 'row',
    flex: 1,
    justifyContent: 'space-around'
  }
});

export { WarshipDetail };
