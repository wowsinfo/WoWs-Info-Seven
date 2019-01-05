/**
 * WarshipDetail.js
 * 
 * Display detailed info of a ship and also show similar ships
 */

import React, { PureComponent } from 'react';
import { View, FlatList,Linking, ScrollView, StyleSheet } from 'react-native';
import { Text, Title, Subheading, Headline, Button, Surface, Paragraph, List, Divider } from 'react-native-paper';
import { WoWsInfo, WikiIcon, WarshipCell, LoadingModal, PriceLabel, LoadingIndicator, WarshipStat, InfoLabel, DividerPlus } from '../../component';
import { SAVED, SERVER, LOCAL } from '../../value/data';
import lang from '../../value/lang';
import { SafeFetch, langStr, Guard, getColourWithRange } from '../../core';
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
        <Divider />
        { this.renderSurvivability(curr) }
        <Divider />
        { this.renderMainBattery(Guard(curr, 'default_profile.artillery', null)) }
        <Divider />
        { this.renderSecondary(Guard(curr, 'default_profile.atbas', null)) }
        <Divider />
        { this.renderTorpedo(Guard(curr, 'default_profile.torpedoes', null)) }
        <Divider />
        { this.renderAADefense(Guard(curr, 'default_profile.anti_aircraft', null)) }
        <Divider />
        { this.renderMobility(Guard(curr, 'default_profile.mobility', null)) }
        <Divider />
        { this.renderConcealment(curr) }
        <Divider />
        { this.renderUpgrade(curr) }
      </View>
    )
  }

  /**
   * Render ship overall status
   * @param {*} profile 
   */
  renderStatus(profile) {
    if (!profile) return null;
    return <WarshipStat profile={profile} />;
  }

  /**
   * Render information about health, armour
   */
  renderSurvivability(curr) {
    if (!curr) return null;
    let armour = Guard(curr, 'default_profile.armour', null);
    let tier = Guard(curr, 'tier', null);

    const { flood_prob, range, health } = armour;
    const { horizontal, centerText } = styles;
    return (
      <View style={{margin: 8}}>
        <Headline style={centerText}>{lang.warship_survivability}</Headline>
        <View style={horizontal}>
          <InfoLabel title={lang.warship_survivability_health} info={`${health} - ${health + tier * 350}`}/>
          <InfoLabel title={lang.warship_survivability_armour} info={range.max + 'mm - ' + range.min + 'mm'}/>
          { flood_prob == 0 ? null : <InfoLabel title={lang.warship_survivability_protection} info={`${flood_prob}%`}/> }
        </View>
      </View>
    );
  }

  /**
   * Render main battery and secondary information
   */
  renderMainBattery(artillery) {
    if (!artillery) return null;
    const { horizontal, centerText } = styles;
    const { max_dispersion, gun_rate, distance, rotation_time, slots, shells } = artillery;
    const { AP, HE } = shells;

    // Get all guns
    var mainGun = '', gunName = '';
    for (gun in slots) mainGun += slots[gun].guns + ' x ' + slots[gun].barrels + '  '; gunName = slots[gun].name;
    // Get gun penetration
    let calibar = parseInt(gunName.split(' ')[0]);
    if (HE) {
      var fireRate = calibar > 160 ? 4 : 3;
      fireRate += HE.burn_probability;
    }

    return (
      <View style={{margin: 8}}>
        <Headline style={centerText}>{lang.warship_artillery_main}</Headline>
        <View style={horizontal}>
          <InfoLabel title={lang.warship_weapon_reload} info={`${Number(60 / gun_rate).toFixed(1)} s`}/>
          <InfoLabel title={lang.warship_weapon_range} info={`${Number(distance).toFixed(2)} km`}/>
          <InfoLabel title={lang.warship_weapon_configuration} info={mainGun}/>
        </View>
        <View style={horizontal}>
          <InfoLabel title={lang.warship_weapon_dispersion} info={`${max_dispersion} m`}/>
          <InfoLabel title={lang.warship_weapon_rotation} info={`${rotation_time} s`}/>
        </View>
        <Title style={centerText}>{gunName}</Title>            
        <View style={horizontal}>
          { HE == null ? null : <View>
            <Title style={centerText}>HE</Title>
            <InfoLabel title={lang.warship_weapon_fire_chance} info={`🔥 ${HE.burn_probability}% - ${fireRate}%`}/>
            <InfoLabel title={lang.warship_artillery_main_weight} info={`${HE.bullet_mass} kg`}/>
            <InfoLabel title={lang.warship_weapon_damage} info={`${HE.damage}`}/>
            <InfoLabel title={lang.warship_weapon_speed} info={`${HE.bullet_speed} m/s`}/>
          </View> }
          { AP == null ? null : <View>
            <Title style={centerText}>AP</Title>          
            <InfoLabel title={lang.warship_weapon_fire_chance} info='0% 🔥'/>
            <InfoLabel title={lang.warship_artillery_main_weight} info={`${AP.bullet_mass} kg`}/>
            <InfoLabel title={lang.warship_weapon_damage} info={`${AP.damage}`}/>
            <InfoLabel title={lang.warship_weapon_speed} info={`${AP.bullet_speed} m/s`}/>
          </View> }
        </View>
      </View>
    );
  }

  /**
   * Render secondary information
   */
  renderSecondary(secondary) {
    if (!secondary) return null;
    const { horizontal, centerText } = styles;
    const { distance, slots } = secondary;

    var guns = []; for (gun in slots) guns.push(slots[gun]);
    return (
      <View style={{margin: 8}}>
        <Headline style={centerText}>{`${lang.warship_artillery_secondary} (${distance} km)`}</Headline>
        { guns.map((value, index) => { 
          const { burn_probability, bullet_speed, name, gun_rate, damage, type } = value;            
          return (
            <View key={index}>
              <Title style={centerText}>{`${type} - ${name}`}</Title>
              <View style={horizontal}>
                <InfoLabel title={lang.warship_weapon_reload} info={Number(60 / gun_rate).toFixed(1) + ' s'}/>
                <InfoLabel title={lang.warship_weapon_speed} info={`${bullet_speed} m/s`}/>
                { burn_probability == null ? null : 
                  <InfoLabel title={lang.warship_weapon_fire_chance} info={`🔥 ${burn_probability}%`} /> }
                <InfoLabel title={lang.warship_weapon_damage} info={damage}/>
              </View>
            </View>
          );
        })}
      </View>
    );
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
  renderTorpedo(torpedoes) {
    if (!torpedoes) return null;
    const { horizontal, centerText } = styles;
    const { visibility_dist, distance, torpedo_name, reload_time, torpedo_speed, slots, max_damage } = torpedoes;

    let torps = ''; for (torp in slots) torps += slots[torp].guns + ' x ' + slots[torp].barrels + '  ';
    let reactionTime = Number(visibility_dist * 1000 / 2.6 / torpedo_speed).toFixed(1);
    return (
      <View style={{margin: 8}}>
        <Headline style={centerText}>{lang.warship_torpedoes}</Headline>
        <View style={horizontal}>
          <InfoLabel title={lang.warship_weapon_reload} info={`${reload_time} s`}/>
          <InfoLabel title={lang.warship_weapon_range} info={`${distance} km`}/>
          <InfoLabel title={lang.warship_weapon_configuration} info={torps}/>
        </View>
        <Title style={centerText}>{`${torpedo_name} (${reactionTime} s)`}</Title>
        <View style={horizontal}>
          <InfoLabel title={lang.warship_torpedoes_visible_distance} info={`${visibility_dist} km`}/>
          <InfoLabel title={lang.warship_weapon_damage} info={max_damage}/>
          <InfoLabel title={lang.warship_weapon_speed} info={`${torpedo_speed} kt`}/>
        </View>
      </View>
    );
  }

  /**
   * Render aa defense information
   */
  renderAADefense(anti_aircraft) {
    if (!anti_aircraft) return null;
    const { horizontal, centerText } = styles;
    const { slots } = anti_aircraft;

    var AAValues = []; for (aa in slots) AAValues.push(slots[aa]);
    return (
      <View style={{margin: 8}}>
        <Headline style={centerText}>{lang.warship_antiaircraft}</Headline>
        { AAValues.map((value, index) => {
          const { distance, avg_damage, name, guns } = value;
          return (
            <View key={index}>
              <Title style={centerText}>{name}</Title>
              <View style={horizontal}>
                <InfoLabel title={lang.warship_weapon_configuration} info={`${guns}x`} />
                <InfoLabel title={lang.warship_weapon_range} info={`${distance} km`} />
                <InfoLabel title={lang.warship_weapon_damage} info={`${avg_damage} dps`} />
              </View>
            </View>
          );
        })}
      </View>
    );
  }

  /**
   * Render mobility information
   */
  renderMobility(mobility) {
    if (!mobility) return null;
    const { horizontal, centerText } = styles;
    const { rudder_time, turning_radius, max_speed } = mobility;
    let good = getColourWithRange(20, max_speed, 45);
    let speedFlag = Number(max_speed * 1.05).toFixed(0);
    return (
      <View style={{margin: 8}}>
        <Headline style={[centerText, {color: good}]}>{lang.warship_maneuverabilty}</Headline>
        <View style={horizontal}>
          <InfoLabel title={lang.warship_maneuverabilty_rudder_time} info={`${rudder_time} s`}/>
          <InfoLabel title={lang.warship_maneuverabilty_speed} info={`${max_speed} kt - ${speedFlag} kt`}/>
          <InfoLabel title={lang.warship_maneuverabilty_turning} info={`${turning_radius} m`}/>
        </View>
      </View>
    );
  }

  /**
   * Render concealment information
   */
  renderConcealment(curr) {
    if (!curr) return null;
    let concealment = Guard(curr, 'default_profile.concealment', null);
    if (!concealment) return null;

    const { horizontal, centerText } = styles;
    const { detect_distance_by_plane, detect_distance_by_ship } = concealment;

    // Check if ship has concealment module
    let upgrades = Guard(curr, 'upgrades', null);
    let modifier = upgrades.findIndex(u => u === 4265791408) > -1 ? 0.9 : 1;
    let max_concealment = Number(detect_distance_by_ship * 0.9 * modifier * 0.97).toFixed(1);
    return (
      <View style={{margin: 8}}>
        <Headline style={centerText}>{lang.warship_concealment}</Headline>
        <View style={horizontal}>
          <InfoLabel title={lang.warship_concealment_detect_by_plane} info={`${detect_distance_by_plane} km`}/>
          <InfoLabel title={lang.warship_concealment_detect_by_ship} info={`${detect_distance_by_ship} km - ${max_concealment} km`}/>
        </View>
      </View>
    );
  }

  /**
   * Render upgrade list
   */
  renderUpgrade(curr) {
    if (!curr) return null;
    let upgrades = Guard(curr, 'upgrades', null);
    let slots = Guard(curr, 'mod_slots', null);
    if (!upgrades || !slots) return null;
    
    // follow the order from global wiki
    upgrades.sort((a, b) => b - a);
    for (let index in upgrades) {
      let id = upgrades[index];
      upgrades[index] = Object.assign(DATA[SAVED.consumable][id]);
    }

    let count = [];
    for (let i = 0; i < slots; i++) {
      count.push(i);
    }

    const { centerText } = styles;
    return (
      <View style={{margin: 8}}>
        <Headline style={centerText}>{lang.warship_upgrades}</Headline>
        <ScrollView>
          { count.map(num => {
            let all = upgrades.filter(u => u.slot == num + 1);
            return (
              <View style={{flexDirection: 'row'}} key={num}>
                <Title>{`${num + 1}.`}</Title>
                { all.map(item => <WikiIcon key={item.name} item={item}/>) }
              </View>
            )})}
        </ScrollView>
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
          <FlatList data={ships} horizontal keyExtractor={shipKey} renderItem={({item}) => {  
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
  weaponTitle: {
    textAlign: 'center',
    margin: -16
  },
  horizontal: {
    flexDirection: 'row',
    flex: 1,
    justifyContent: 'space-around'
  }
});

export { WarshipDetail };
