/**
 * Info6Icon.js
 *
 * The classic 6 icons
 */

import React, {Component} from 'react';
import {View, StyleSheet} from 'react-native';
import {IconLabel} from './IconLabel';
import {roundTo, bestWidth} from '../../core';

class Info6Icon extends Component {
  state = {
    cellWidth: bestWidth(100),
  };

  updateBestWidth = event => {
    const goodWidth = event.nativeEvent.layout.width;
    this.setState({bestItemWidth: bestWidth(400, goodWidth)});
  };

  render() {
    const {container, wrap} = styles;
    const {data, compact, topOnly} = this.props;
    if (!data) return null;

    const {cellWidth} = this.state;
    const {
      battles,
      wins,
      damage_dealt,
      frags,
      xp,
      survived_battles,
      main_battery,
    } = data;
    const {hits, shots} = main_battery;
    const death = battles - survived_battles;

    const labelStyle = {width: cellWidth};
    return (
      <View
        style={[
          wrap,
          compact
            ? {marginTop: 0, marginBottom: 0}
            : {marginTop: 16, marginBottom: 16},
        ]}
        onLayout={this.updateBestWidth}>
        <IconLabel
          icon={require('../../img/Battle.png')}
          info={battles}
          style={labelStyle}
        />
        <IconLabel
          icon={require('../../img/WinRate.png')}
          info={`${roundTo((wins / battles) * 100, 2)}%`}
          style={labelStyle}
        />
        <IconLabel
          icon={require('../../img/Damage.png')}
          info={roundTo(damage_dealt / battles)}
          style={labelStyle}
        />
        {topOnly ? null : (
          <>
            <IconLabel
              icon={require('../../img/EXP.png')}
              info={roundTo(xp / battles)}
              style={labelStyle}
            />
            <IconLabel
              icon={require('../../img/KillDeathRatio.png')}
              info={roundTo(frags / death, 2)}
              style={labelStyle}
            />
            <IconLabel
              icon={require('../../img/HitRatio.png')}
              info={`${roundTo((hits / shots) * 100, 2)}%`}
              style={labelStyle}
            />
          </>
        )}
      </View>
    );
  }

  renderBottom;
}

const styles = StyleSheet.create({
  wrap: {
    flex: 1,
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'center',
  },
});

export {Info6Icon};
