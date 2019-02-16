import React, { PureComponent } from 'react';
import { View, ScrollView, StyleSheet } from 'react-native';
import { VictoryBar, VictoryTheme, VictoryChart, VictoryPie, VictoryAxis } from "victory-native";
import { WoWsInfo, SectionTitle } from '../../component';
import { SAVED } from '../../value/data';
import { SafeValue, roundTo } from '../../core';
import { TintColour } from '../../value/colour';
import { Text, Title } from 'react-native-paper';
import { VictoryLabel } from 'victory-core/es';

class Graph extends PureComponent {
  constructor(props) {
    super(props);
    const { data } = this.props;
    console.log(data);

    let tierInfo = {};
    let nationInfo = {};
    let typeInfo = {};
    let totalBattle = 0;
    for (let ship of data) {
      // Get info we need
      const { pvp, ship_id } = ship; 
      const { battles } = pvp;

      let curr = DATA[SAVED.warship][ship_id];
      if (curr == null) continue;

      const { nation, tier, type } = curr;
      tierInfo[tier] = SafeValue(tierInfo[tier], 0) + battles;
      nationInfo[nation] = SafeValue(nationInfo[nation], 0) + battles;
      typeInfo[type] = SafeValue(typeInfo[type], 0) + battles;
      totalBattle += battles;
    }

    this.state = {
      tier: this.objToChart(tierInfo),
      avgTier: this.getAvgTier(tierInfo),
      nation: this.objToChart(nationInfo, DATA[SAVED.encyclopedia].ship_nations, 10),
      type: this.objToChart(typeInfo, DATA[SAVED.encyclopedia].ship_types),
    };
  }

  objToChart(obj, name, min = 0) {
    // Key will be x and Value will be y
    let chart = [];
    for (let key in obj) {
      let val = obj[key];
      if (val === 0 || val < min) continue;

      let label = key;
      if (name) label = name[key]

      chart.push({x: label, y: val});
    }
    console.log(chart);
    return chart;
  }

  getAvgTier = (tier) => {
    let weight = 0;
    let total = 0;
    for (let key in tier) {
      let curr = tier[key];
      weight += curr * Number(key);
      total += curr;
    }
    return roundTo(weight / total, 1);
  }

  render() {
    const { container } = styles;
    const { tier, avgTier, nation, type } = this.state;
    const themeColour = TintColour()[500];
    return (
      <WoWsInfo>
        <ScrollView>
          <View pointerEvents='none'>
            {/* <Title>{`Average Tier - ${avgTier}`}</Title> */}
            <VictoryChart domainPadding={10}>
              <VictoryAxis/>
              <VictoryBar theme={VictoryTheme.material}
                style={{data: {fill: themeColour}, labels: {fontSize: 12, fill: themeColour}}} data={tier} labels={d => d.y}/>
            </VictoryChart>
            <VictoryPie style={{labels: {fontSize: 12, fill: themeColour}}} data={nation} padAngle={3}
            colorScale={["tomato", "orange", "gold", "cyan", "navy" ]}/>
            <VictoryPie theme={VictoryTheme.material} data={type} />
          </View>
        </ScrollView>
      </WoWsInfo>
    )
  };

  renderLabel = () => <VictoryLabel style={{color: TintColour()[500]}}/>
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export { Graph };
