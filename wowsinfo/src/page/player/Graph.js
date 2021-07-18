import React, {PureComponent} from 'react';
import {View, ScrollView, StyleSheet} from 'react-native';
import {Title} from 'react-native-paper';
import {BarChart, PieChart} from 'native-chart-experiment';
import {WoWsInfo} from '../../component';
import {SAVED} from '../../value/data';
import {SafeValue, roundTo} from '../../core';
import {TintColour} from '../../value/colour';

class Graph extends PureComponent {
  constructor(props) {
    super(props);
    const {data} = this.props;
    console.log(data);

    let tierInfo = {};
    let nationInfo = {};
    let typeInfo = {};
    let totalBattle = 0;
    for (let ship of data) {
      // Get info we need
      const {pvp, ship_id} = ship;
      const {battles} = pvp;

      let curr = DATA[SAVED.warship][ship_id];
      if (curr == null) continue;

      const {nation, tier, type} = curr;
      tierInfo[tier] = SafeValue(tierInfo[tier], 0) + battles;
      nationInfo[nation] = SafeValue(nationInfo[nation], 0) + battles;
      typeInfo[type] = SafeValue(typeInfo[type], 0) + battles;
      totalBattle += battles;
    }

    this.state = {
      tier: this.objToChart(tierInfo),
      avgTier: this.getAvgTier(tierInfo),
      nation: this.objToChart(
        nationInfo,
        DATA[SAVED.encyclopedia].ship_nations,
        10,
      ),
      type: this.objToChart(typeInfo, DATA[SAVED.encyclopedia].ship_types),
    };
  }

  objToChart(obj, name, min = 0) {
    // Key will be x and Value will be y
    let chart = {x: [], y: []};
    for (let key in obj) {
      let val = obj[key];
      if (val === 0 || val < min) continue;

      let label = key;
      if (name) label = name[key];

      chart.x.push(label);
      chart.y.push(val);
    }
    console.log(chart);
    return chart;
  }

  getAvgTier = tier => {
    let weight = 0;
    let total = 0;
    for (let key in tier) {
      let curr = tier[key];
      weight += curr * Number(key);
      total += curr;
    }
    return roundTo(weight / total, 1);
  };

  render() {
    const {container} = styles;
    const {tier, avgTier, nation, type} = this.state;
    const themeColour = TintColour()[500];
    return (
      <WoWsInfo hideAds>
        <ScrollView>
          {/* <Title style={{textAlign: 'center'}}>{`Average Tier - ${avgTier}`}</Title> */}
          <BarChart
            style={{height: 300}}
            darkMode={DARKMODE}
            themeColor={TintColour()[500]}
            chartData={tier.y}
            xAxisLabels={tier.x}
          />
          <PieChart
            style={{height: 300}}
            darkMode={DARKMODE}
            chartData={nation.y}
            dataLabels={nation.x}
          />
          <PieChart
            style={{height: 300}}
            darkMode={DARKMODE}
            chartData={type.y}
            dataLabels={type.x}
          />
        </ScrollView>
      </WoWsInfo>
    );
  }

  renderLabel = () => <VictoryLabel style={{color: TintColour()[500]}} />;
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export {Graph};
