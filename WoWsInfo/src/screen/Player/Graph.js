import React, { Component } from 'react';
import { ScrollView, Text } from 'react-native';
import { View } from 'react-native-animatable';
import { NoInformation } from '../../component';
import { VictoryChart, VictoryBar, VictoryPie, VictoryTheme, VictoryLabel, VictoryAxis, VictoryScatter } from 'victory-native';
import { ShipInfo } from '../../core';
import { getTheme } from '../../constant/colour';
import language from '../../constant/language';

class Graph extends Component {
  state = {data: {}}

  componentWillMount() {
    const NUM_OF_SHIP = 8;
    const TYPE = {Destroyer: 0, Cruiser: 1, Battleship: 2, AirCarrier: 3};
    this.TYPE_NAME = [data.ship_type.Destroyer, data.ship_type.Cruiser, data.ship_type.Battleship, data.ship_type.AirCarrier];  

    const { id, server } = this.props;
    let ship = new ShipInfo(id, server);
    ship.getShipInfo().then(json => {
      if (json != null) {
        var shipInfo = [];
        let shipTypeInfo = {Destroyer: [], Cruiser: [], Battleship: [], AirCarrier: []};
        let tierInfo = [{name: 'I', count: 0}, {name: 'II', count: 0}, {name: 'III', count: 0}, {name: 'IV', count: 0}, {name: 'V', count: 0}, 
          {name: 'VI', count: 0}, {name: 'VII', count: 0}, {name: 'VIII', count: 0}, {name: 'IX', count: 0}, {name: 'X', count: 0}];
        let typeBattleInfo = [{name: this.TYPE_NAME[0], battle: 0}, {name: this.TYPE_NAME[1], battle: 0}, 
          {name: this.TYPE_NAME[2], battle: 0}, {name: this.TYPE_NAME[3], battle: 0}]    
          
        for (var i = 0; i < json.length; i++) {
          let curr = json[i];
          // Ignore ships with less than 5 battles
          if (curr.battles != null && curr.battles > 4) {
            delete curr.pvp;
            let ship = data.warship[curr.ship_id];
            if (ship == null) continue; 
            curr.ap = parseInt(curr.ap)
            curr.type = ship.type; curr.name = ship.name; curr.tier = ship.tier;
            shipInfo.push(json[i]);
            tierInfo[curr.tier - 1].count += curr.battles;
            // Create dd, ca, bb and cv sub array
            shipTypeInfo[curr.type].push(json[i]);
            // Calculate total battle for each type
            let currType = TYPE[curr.type];
            typeBattleInfo[currType].battle += curr.battles;
          }
        }
        
        // Only if player has more than ten ships
        if (shipInfo.length > 10) {
          let graphData = {};
          // Get top 10 played ship
          shipInfo.sort(function (a, b) {return b.battles - a.battles;})
          graphData.battle = shipInfo.slice(0, NUM_OF_SHIP);

          // Get top 10 average damage
          shipInfo.sort(function (a, b) {return b.avg_damage - a.avg_damage;})
          graphData.damage = shipInfo.slice(0, NUM_OF_SHIP);        

          // Get top 10 win rate
          shipInfo.sort(function (a, b) {return b.win_rate - a.win_rate;})
          graphData.win = shipInfo.slice(0, NUM_OF_SHIP);        

          // Get ship type count
          const { AirCarrier, Battleship, Cruiser, Destroyer } = shipTypeInfo;
          // Get top 5 dd
          Destroyer.sort(function (a, b) {return b.ap - a.ap;})    
          shipTypeInfo.Destroyer = Destroyer.slice(0, NUM_OF_SHIP);      
          // Get top 5 ca
          Cruiser.sort(function (a, b) {return b.ap - a.ap;})  
          shipTypeInfo.Cruiser = Cruiser.slice(0, NUM_OF_SHIP);                        
          // Get top 5 bb
          Battleship.sort(function (a, b) {return b.ap - a.ap;})    
          shipTypeInfo.Battleship = Battleship.slice(0, NUM_OF_SHIP);                      
          // Get top 5 cv
          AirCarrier.sort(function (a, b) {return b.ap - a.ap;})
          shipTypeInfo.AirCarrier = AirCarrier.slice(0, NUM_OF_SHIP);

          graphData.type = shipTypeInfo;      
          graphData.tier = tierInfo;  
          graphData.typeBattle = typeBattleInfo;
          this.setState({data: graphData});
        }
      }
    })
  }

  render() {
    const { data } = this.state;
    if (data.battle != null) {
      const { AirCarrier, Battleship, Cruiser, Destroyer } = data.type;
      console.log(data, language, this.TYPE_NAME[0]);      
      return (
        <View animation='fadeInUp'>        
         <ScrollView contentInset={{bottom: 50}}>
          <View pointerEvents='none'>
            { this.renderTitle(language.graph_tier) }            
            <VictoryChart domainPadding={10}>
              <VictoryBar labels={(data) => data['count']} data={data.tier} x='name' y='count'
                style={{data: {fill: 'deepskyblue', opacity: 0.7}, labels: {fontSize: 12}}}/>
                <VictoryAxis orientation='bottom' style={{axis: {stroke: 'transparent'}}}/>
            </VictoryChart>
          </View>
          <View pointerEvents='none'>
            { this.renderTitle(language.graph_damage) }
            <VictoryChart domainPadding={10} padding={{top: 20, bottom: 50, left: 96, right: 10}}>
              <VictoryScatter data={data.damage} x='avg_damage' y='name'
                style={{data: {fill: 'green', opacity: 0.7}, labels: {fontSize: 12}}}/>          
            </VictoryChart>
          </View>
          <View pointerEvents='none'>
            { this.renderTitle(language.graph_battle) }            
            <VictoryChart domainPadding={10} padding={{top: 20, bottom: 50, right: 64}}>
              <VictoryBar horizontal labels={(data) => data['name']} data={data.battle} x='name' y='battles'
                style={{data: {fill: 'red', opacity: 0.7}, labels: {fontSize: 12}}}/>
                <VictoryAxis orientation='bottom' style={{axis: {stroke: 'transparent'}}}/>
            </VictoryChart>
          </View>
          <View pointerEvents='none'>
             { this.renderTitle(language.graph_winarte) }            
            <VictoryChart domainPadding={10} padding={{top: 40, bottom: 50, right: 64}}>
              <VictoryBar horizontal labels={(data) => data['name']} data={data.win} x='name' y='win_rate'
                style={{data: {fill: 'blue', opacity: 0.7}, labels: {fontSize: 12}}}/>
                <VictoryAxis tickFormat={(tick) => `${tick}%`}
                  orientation='top' style={{axis: {stroke: 'transparent'}}}/>
            </VictoryChart>
          </View>
           
          <View pointerEvents='none'>
            { this.renderTitle(language.graph_type) }
            <VictoryPie labelRadius={96} padding={{right: 64, left: 32}} innerRadius={64}
              padAngle={3} colorScale={['orange', 'aquamarine', 'dodgerblue', 'hotpink']} data={data.typeBattle} x='name' y='battle'/>
          </View>
            { this.renderTitle(this.TYPE_NAME[0] + language.graph_top) }
            { this.renderTopShip(Destroyer, 'orange') }
            { this.renderTitle(this.TYPE_NAME[1] + language.graph_top) }            
            { this.renderTopShip(Cruiser, 'blueviolet') }
            { this.renderTitle(this.TYPE_NAME[2] + language.graph_top) }            
            { this.renderTopShip(Battleship, 'brown') }
            { this.renderTitle(this.TYPE_NAME[3] + language.graph_top) }            
            { this.renderTopShip(AirCarrier, 'gray') }
          </ScrollView>
        </View>         
      )
    } else return <NoInformation />
  }

  /**
   * Render basic title
   * @param {*} title 
   */
  renderTitle(title) {
    return <Text style={{paddingLeft: 8, marginTop: 4, fontSize: 20, fontWeight: 'bold', color: getTheme(), textAlign: android ? 'left' : 'center'}}>{title}</Text>
  }

  /**
   * Render basic horizontal graph
   * @param {*} ship 
   * @param {*} colour 
   */
  renderTopShip(ship, colour) {
    if (ship.length > 2) {
      return (
        <View pointerEvents='none'>
          <VictoryChart domainPadding={10} padding={{top: 20, bottom: 50, right: 64}}>
            <VictoryBar horizontal labels={(data) => data['name']} data={ship} x='name' y='ap'
              style={{data: {fill: colour, opacity: 0.7}, labels: {fontSize: 12}}}/>
              <VictoryAxis orientation='bottom' style={{axis: {stroke: 'transparent'}}}/>
          </VictoryChart>
        </View>
    )} else return null;
  }
}

export { Graph };