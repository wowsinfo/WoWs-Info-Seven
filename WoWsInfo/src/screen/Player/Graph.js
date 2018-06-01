import React, { Component } from 'react';
import { View } from 'react-native';
import { NoInformation } from '../../component';
import { VictoryChart, VictoryBar, VictoryPie, VictoryTheme, VictoryLabel, VictoryAxis, VictoryGroup } from 'victory-native';
import { ShipInfo } from '../../core';

class Graph extends Component {
  state = {data: {}}

  componentWillMount() {
    const { id, server } = this.props;
    let ship = new ShipInfo(id, server);
    ship.getShipInfo().then(json => {
      if (json != null) {
        var shipInfo = [];
        for (var i = 0; i < json.length; i++) {
          let curr = json[i];
          if (curr.battles != null) {
            delete curr.pvp;
            let ship = data.warship[curr.ship_id];
            if (ship == null) continue; 
            curr.type = ship.type; curr.name = ship.name;
            shipInfo.push(json[i]);
          }
        }
        
        // Only if player has more than ten ships
        if (shipInfo.length > 10) {
          console.log(shipInfo);

          let graphData = {};
          // Get top 10 played ship
          shipInfo.sort(function (a, b) {return b.battles - a.battles;})
          graphData.battle_10 = [];
          let battle_10 = shipInfo.slice(0, 10);
          for (battle in battle_10) {
            let curr = battle_10[battle];
            graphData.battle_10.push({battle: curr.battles, name: curr.name});
          }

          // Get top 10 average damage
          shipInfo.sort(function (a, b) {return b.avg_damage - a.avg_damage;})
          graphData.damage_10 = shipInfo.slice(0, 10);        

          // Get top 10 win rate
          shipInfo.sort(function (a, b) {return b.win_rate - a.win_rate;})
          graphData.win_10 = shipInfo.slice(0, 10);        

          // Get ship type count
          // Get top 5 dd
          // Get top 5 ca
          // Get top 5 cv
          // Get top 5 bb

          this.setState({data: graphData});
        }
      }
    })
  }

  render() {
    const { data } = this.state;
    console.log(data);
    if (data.battle_10 != null) {
      return (
        <View>
          <VictoryChart domainPadding={10} padding={{ top: 20, bottom: 50, right: 40 }}>
            <VictoryBar horizontal labels={(data) => data.name} data={data.battle_10} x='name' y='battle'
              style={{data: {fill: 'red', opacity: 0.7}, labels: {fontSize: 12}}}/>
              <VictoryAxis orientation='bottom' style={{axis: {stroke: "transparent"}}}/>
          </VictoryChart>
        </View>
      )
    } else return <NoInformation />
  }
}

export { Graph };