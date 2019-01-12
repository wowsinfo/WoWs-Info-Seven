/**
 * CommanderSkill.js
 * 
 * Display commander skills in tiers
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Surface, Title } from 'react-native-paper';
import { SAVED } from '../../value/data';
import { WoWsInfo, WikiIcon } from '../../component';
import GridView from 'react-native-super-grid';
import { Actions } from 'react-native-router-flux';
import { SafeAction } from '../../core';
import lang from '../../value/lang';

class CommanderSkill extends Component {
  constructor(props) {
    super(props);

    console.log("WIKI - Commander Skill");
    let skill = DATA[SAVED.commanderSkill];
    let backup = JSON.stringify(skill);
  
    this.state = {
      data: JSON.parse(backup),
      point: 19
    };
  }

  render() {
    const { data, point } = this.state;

    return (
      <WoWsInfo title={`${point} ${lang.wiki_skills_point}`} onPress={() => this.reset()}>
        <GridView itemDimension={80} items={data} renderItem={item => {
          return <WikiIcon item={item} selected={item.selected} onPress={() => {
            let pointLeft = point;
            if (item.selected == true) {
              // Remember to set it to a number otherwise you will have weird issues
              if (pointLeft == lang.wiki_skills_reset) pointLeft = 0;
              pointLeft += item.tier;
              // Deselect this skill and return your points
              item.selected = false;
              this.setState({point: pointLeft});
            } else {
              pointLeft -= item.tier;
              if (pointLeft >= 0) {
                item.selected = true;
                // If you do not have enough point do nothing
                if (pointLeft == 0) this.setState({point: lang.wiki_skills_reset});
                else this.setState({point: pointLeft});
              }
            }
          }} onLongPress={() => SafeAction('BasicDetail', {item: item})}/>
        }}/>
      </WoWsInfo>
    )
  };

  reset() {
    const { data } = this.state;
    data.forEach(s => delete s.selected);
    this.setState({point: 19, data: data});
  }
}

const styles = StyleSheet.create({
  header: {
    textAlign: 'center'
  }
});

export { CommanderSkill };
