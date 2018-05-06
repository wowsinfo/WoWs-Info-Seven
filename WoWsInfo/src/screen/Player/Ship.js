import React, { PureComponent } from 'react';
import { View, Text, TextInput, Keyboard, StyleSheet } from 'react-native';
import { Icon } from 'react-native-elements';
import { NoInformation, WoWsLoading, ShipInfoCell } from '../../component';
import GridView from 'react-native-super-grid';
import { ShipInfo, PersonalRating } from '../../core';
import language from '../../constant/language';

class Ship extends PureComponent {
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
    const { id, server } = this.props;
    let ship = new ShipInfo(id, server);
    ship.getShipInfo().then(json => {
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
      if (data.length > 0) {
        const { footerViewStyle, poweredStyle, totalShipStyle, mainViewStyle, filterViewStyle, filterButtonStyle, dropdownStyle, dropdownTextStyle, inputStyle, resetBtnStyle } = styles;        
        return (
          <View>
            <View style={footerViewStyle}>
              <Text style={poweredStyle}>{language.player_powered_by_number}</Text>
              <Text style={totalShipStyle}>{data.length}</Text>
            </View>
            { this.renderHeader() }
            <View>
              <GridView itemDimension={300} items={data} onScroll={Keyboard.dismiss}
                renderItem={item => <ShipInfoCell info={item}/>}/>
            </View>
            
          </View>
        ) 
      } else {
        const { noInfoTextStyle, noInfoViewStyle } = styles;
        return <NoInformation />
      }
    } else return <WoWsLoading />;
  }

  renderResetButton() {
    return (
      <Icon name='md-refresh' type='ionicon' color='white' underlayColor='transparent' containerStyle={styles.resetStyle} onPress={() => {
        // Reset stuff
        this.filter = {name: '', nation: '', type: ''};
        this.refs.nationDropdown.select(-1);          
        this.refs.typeDropdown.select(-1);
        this.refs.filterInput.clear(0);
        this.setState({
          data: this.shipInfo,
          overall: this.overall,
        })
      }}/>
    )
  }

  renderHeader = () => {
    let ratingInfo = this.getOverallRatingInfo(this.state.overall);    
    return (
      <Text style={[styles.ratingStyle, {color: ratingInfo.colour}]}>{ratingInfo.comment}</Text>      
    )
  }

  getOverallRatingInfo(index) {
    var ratingInfo = {};
    ratingInfo.colour = PersonalRating.getColour(index);
    ratingInfo.comment = PersonalRating.getComment(index);
    return ratingInfo;
  }

  onChangeText = (text) => {
    this.filter.name = text;
    this.filterShip();
  }

  filterNation = (index, value) => {
    // Find key
    var nationKey = '';
    for (key in this.json.ship_nations) {
      let nation = this.json.ship_nations[key];
      if (value == nation) {
        // This is the key we want
        this.filter.nation = key; 
        this.filterShip();
        break;
      }
    }   
  }

  filterType = (index, value) => {
    // Find key
    for (key in this.shipType) {
      let type = this.shipType[key];
      if (value == type) {
        // This is the key we want
        this.filter.type = key; 
        this.filterShip();
        break;
      }
    }
    
  }

  filterShip() {
    // Filter ship according to this.filter
    var filtered = [];
    var totalDamage = 0, totalWin = 0, totalFrag = 0, expectedDamage = 0, expectedWin = 0, expectedFrag = 0;    
    for (var i = 0; i < this.shipInfo.length; i++) {
      let entry = this.shipInfo[i];
      // Check 3 times
      let currShip = global.warshipJson[entry.ship_id];
      if (currShip == null) continue;
      if (this.filter.name != '') {
        let number = parseInt(this.filter.name);
        if (number != null && number > 0) {
          // If it is a number
          if (number > 0 && number <= 10) {
            // Tier
            if (currShip.tier != number) continue;
          } else {
            // Battle
            if (entry.battle < number) continue;
          }
        } else {
          // Filter by name
          if (!currShip.name.toLowerCase().includes(this.filter.name.toLowerCase())) continue;
        }
      }
      if (this.filter.type != '' && currShip.type != this.filter.type) continue;
      if (this.filter.nation != '' && currShip.nation != this.filter.nation) continue;
      // Valid ship
      filtered.push(entry);
      // Also calculate new rating here
      let currRating = global.personalRatingJson[entry.ship_id];
      totalDamage += entry.avg_damage;
      totalWin += entry.win_rate;
      totalFrag += entry.avg_frag;
      expectedDamage += currRating.average_damage_dealt;
      expectedWin += currRating.win_rate;
      expectedFrag += currRating.average_frags;
    }
    // Sort by tier as always
    filtered.sort(function (a, b) {return b.pr - a.pr;})
    // Get new rating
    let pr = PersonalRating.getTotalRating(totalDamage, expectedDamage, totalWin, expectedWin, totalFrag, expectedFrag);
    this.setState({
      data: filtered,
      overall: PersonalRating.getIndex(pr),
    })
  }
}

const styles = StyleSheet.create({
  mainViewStyle: {
    flex: 1,
  },
  ratingStyle: {
    textAlign: 'center',
    fontSize: 24,
    fontWeight: 'bold',
    margin: 4,
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
    flex: 0.9,
    paddingLeft: 8
  },
  totalShipStyle: {
    flex: 0.1,
    alignItems: 'flex-end',
  }
})

export {Ship};