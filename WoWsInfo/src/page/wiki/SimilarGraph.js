/**
 * SimilarGraph.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, ScrollView, StyleSheet } from 'react-native';
import { WoWsInfo } from '../../component';
import { SAVED } from '../../value/data';
import { VictoryChart, VictoryBar, VictoryAxis } from 'victory-native';
import { TintColour, ThemeColour } from '../../value/colour';
import { roundTo } from '../../core';
import { Title } from 'react-native-paper';
import { lang } from '../../value/lang';

class SimilarGraph extends Component {
  constructor(props) {
    super(props);
    const { info } = this.props;

    let damageChart = [];
    let winrateChart = [];
    let fragChart = [];
    for (let ship of info) {
      let overall = DATA[SAVED.pr][ship.ship_id];
      if (overall == null) continue;

      const { average_damage_dealt, average_frags, win_rate } = overall;
      let name = ship.name;
      damageChart.push({x: name, y: roundTo(average_damage_dealt)});
      winrateChart.push({x: name, y: roundTo(win_rate, 1)});
      fragChart.push({x: name, y: roundTo(average_frags, 2)});
    }

    this.state = {
      damageChart: damageChart,
      winrateChart: winrateChart,
      fragChart: fragChart
    };
  }

  render() {
    const { damageChart, winrateChart, fragChart } = this.state;
    const { graphTitle } = styles;
    const themeColour = TintColour()[500];

    let data = [{n: lang.warship_avg_damage, d: damageChart},
      {n: lang.warship_avg_winrate, d: winrateChart},
      {n: lang.warship_avg_frag, d: fragChart}];

    return (
      <WoWsInfo>
        <ScrollView>
          { data.map(c => {
            return (
              <View pointerEvents='none' key={c.n}>
                <Title style={graphTitle}>{c.n}</Title>
                <VictoryChart height={winrateChart.length * 30} padding={{left: 100, top: 20, bottom: 20, right: 60}}>
                  <VictoryAxis dependentAxis style={{tickLabels: {fill: themeColour}}}/>
                  <VictoryBar style={{data: {fill: themeColour}, labels: {fontSize: 12, fill: themeColour}}}
                    horizontal data={c.d} labels={d => d.y} />
                </VictoryChart>
              </View>
            )
          }) }
        </ScrollView>
      </WoWsInfo>
    )
  };
}

const styles = StyleSheet.create({
  graphTitle: {
    alignSelf: 'center',
    padding: 8,
    paddingBottom: 0
  }
});

export { SimilarGraph };
