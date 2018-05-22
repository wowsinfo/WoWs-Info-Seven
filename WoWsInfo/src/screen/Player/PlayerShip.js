import React, { PureComponent } from 'react';
import { Text, TextInput, Keyboard, StyleSheet, Image } from 'react-native';
import { View } from 'react-native-animatable';
import { Icon, Divider } from 'react-native-elements';
import { NoInformation, WoWsLoading, ShipInfoCell, WoWsTouchable } from '../../component';
import GridView from 'react-native-super-grid';
import { ShipInfo, PersonalRating } from '../../core';
import language from '../../constant/language';
import { getTheme, navStyle } from '../../constant/colour';
import { iconsMap } from '../../constant/icon';
import { hapticFeedback } from '../../app/App';

class PlayerShip extends PureComponent {
  constructor(props) {
    super(props);

    // Format nation and type json
    this.filter = {tier: '', nation: '', type: ''};
    this.state = {
      isReady: false, data: [], overall: 0
    }  
  }

  componentWillMount() {
    // Load data here and calculate personal rating
    const { id, server, rank } = this.props;
    let ship = new ShipInfo(id, server);
    ship.getShipInfo(rank).then(json => {
      if (json != null) {
        var shipInfo = [];
        for (var i = 0; i < json.length; i++) {
          if (json[i].battles != null) shipInfo.push(json[i]);
        }
        // Sort by  rating
        shipInfo.sort(function (a, b) {return b.ap - a.ap;})
        this.shipInfo = shipInfo;
        this.overall = json.overall;
        this.setState({
          isReady: true,
          data: shipInfo,
          overall: json.overall,
        })
      }
    })
  }

  render() {
    const { isReady, data } = this.state;
    if (isReady) {
      const { mainViewStyle, filterViewStyle, filterButtonStyle, dropdownStyle, dropdownTextStyle, inputStyle, resetBtnStyle } = styles;        
      return (
        <View style={mainViewStyle} ref='playership' animation={this.props.rank != null ? '' :'fadeInUp'}>
          { this.renderRating() }
          <GridView itemDimension={300} items={data} onScroll={Keyboard.dismiss}
            contentInset={{bottom: 50}} renderItem={item => <ShipInfoCell detail={this.pushToDetail} info={item}/>}/>
        </View>
      )
    } else return <WoWsLoading />;
  }

  pushToDetail = (item) => {
    this.props.navigator.push({
      screen: 'player.ship',
      title: String(item.ship_id),
      navigatorStyle: navStyle(),
      passProps: {info: item}
    })
  }

  renderRating = () => {
    const { overall, data } = this.state;
    let ratingInfo = this.getOverallRatingInfo(overall); 
    console.log(ratingInfo);
    const { iconStyle, iconViewStyle, footerViewStyle, ratingViewStyle, poweredStyle, totalShipStyle, ratingStyle } = styles;   
    return (
      <View>
        <View style={footerViewStyle}>
          <Text style={poweredStyle}>{language.player_powered_by_number}</Text>
          <Text style={totalShipStyle}>{data.length}</Text>
        </View>
        <View style={ratingViewStyle}>
          <Text style={[ratingStyle, {color: ratingInfo.colour}]}>{ratingInfo.comment}</Text> 
          <View style={iconViewStyle}>
            <WoWsTouchable onPress={this.resetFilter}><Image source={iconsMap['undo']} style={[iconStyle, {tintColor: getTheme()}]}/></WoWsTouchable>
            <WoWsTouchable onPress={this.pushToFilter}><Image source={iconsMap['filter']} style={[iconStyle, {tintColor: getTheme()}]}/></WoWsTouchable>
          </View>
        </View> 
        <Divider />  
      </View>     
    )
  }

  /**
   * Reset current filter and show animation
   */
  resetFilter = () => {
    const { tier, type, nation } = this.filter;
    if (tier == '' && type == '' & nation == '') return;
    this.filter = {tier: '', nation: '', type: ''};
    this.setState({data: this.shipInfo, overall: this.overall});
    this.refs['playership'].bounceInDown(800) 
  }

  /**
   * Goto filter screen
   */
  pushToFilter = () => {
    this.props.navigator.showModal({
      screen: 'ship.filter',
      navigatorStyle: navStyle(),
      passProps: {filter: this.setFilter, curr: this.filter}
    })
  }

  /**
  * Set ship filter
  */
  setFilter = (filter) => {
    if (filter == this.filter) return;
    this.filter = filter;
    this.filterShip();
  }

  /**
   * Filter ship with tier, type, nation
   */
  filterShip() {
    this.setState({data: []});
    // Remove repeat
    const { tier, type, nation } = this.filter;
    if (tier == '' && type == '' & nation == '') return;
    var totalDamage = 0, totalWin = 0, totalFrag = 0, expectedDamage = 0, expectedWin = 0, expectedFrag = 0;    
    // Filter ship according to this.filter
    var filtered = [];
    for (key in this.shipInfo) {
      let entry = this.shipInfo[key];
      let ship = data.warship[entry.ship_id];
      if (ship == undefined) continue;
      if (tier != '' && ship.tier != tier + 1) continue;
      if (type != '' && ship.type != type) continue;
      if (nation != '' && ship.nation != nation) continue;

      // Also calculate new rating here      
      let currRating = data.personal_rating[entry.ship_id];
      if (currRating == null) continue;
      const { avg_damage, avg_frag } = entry;
      const { average_damage_dealt, win_rate, average_frags } = currRating;
      totalDamage += avg_damage;
      totalWin += entry.win_rate;
      totalFrag += avg_frag;
      expectedDamage += average_damage_dealt;
      expectedWin += win_rate;
      expectedFrag += average_frags;
      // Valid ship
      filtered.push(entry);
    }
    // Sort by AP
    filtered.sort(function (a, b) {return b.ap - a.ap})
    // Get new rating
    let pr = PersonalRating.getTotalRating(totalDamage, expectedDamage, totalWin, expectedWin, totalFrag, expectedFrag);
    hapticFeedback();
    this.setState({data: filtered, overall: PersonalRating.getIndex(pr)})
    this.refs['playership'].bounceInUp(800)
  }

  getOverallRatingInfo(index) {
    var ratingInfo = {};
    ratingInfo.colour = PersonalRating.getColour(index);
    ratingInfo.comment = PersonalRating.getComment(index);
    return ratingInfo;
  }
}

const styles = StyleSheet.create({
  mainViewStyle: {
    flex: 1,
  },
  ratingViewStyle: {
    flexDirection: 'row', justifyContent: 'flex-end'
  },
  iconViewStyle: {
    flexDirection: 'row',
    justifyContent: 'center', alignItems: 'center'   
  },
  iconStyle: {
    height: 28, width: 28, 
    margin: 6
  },
  ratingStyle: {
    textAlign: 'left',
    fontSize: 32,
    fontWeight: 'bold',
    paddingLeft: 8, flex: 1
  },
  filterViewStyle: { 
    flexDirection: 'row', 
    alignItems: 'center', 
    justifyContent: 'center',
  },
  filterButtonStyle: {
    fontSize: 16,
    textAlign: 'center',
    color: 'white',
    margin: 8,
  },
  dropdownStyle: {
    height: 400,
  },
  dropdownTextStyle: {
    fontSize: 16,
    textAlign: 'center',
  },
  inputStyle: {
    width: '40%', 
    borderColor: 'white', 
    fontSize: 16,
    textAlign: 'center',
  },
  resetStyle: {
    marginLeft: 8,
    height: 40,
    width: 40,
  },
  footerViewStyle: {
    flexDirection: 'row',
  },
  poweredStyle: {
    flex: 1,
    paddingLeft: 8
  },
  totalShipStyle: {
    paddingRight: 4,
    alignItems: 'flex-end',
  }
})

export { PlayerShip };