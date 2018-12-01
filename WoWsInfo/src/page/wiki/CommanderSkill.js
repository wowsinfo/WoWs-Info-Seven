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
import { SuperGridSectionList } from 'react-native-super-grid';
import { Actions } from 'react-native-router-flux';

class CommanderSkill extends Component {
  constructor(props) {
    super(props);

    console.log("WIKI - Commander Skill");
    let skill = DATA[SAVED.commanderSkill];
    // Get current max tier
    let maxTier = skill.reduce((max, curr) => Math.max(max, curr.tier), 0);
    if (maxTier != NaN) {
      let section = [];
      let length = 0;
      // Make section list, remember to change to INDEX
      while (length < maxTier) {
        section.push({title: `Lv ${length + 1}`, data: []});
        length++;
      }
  
      skill.forEach(s => section[s.tier - 1].data.push(s));
      console.log(section);
      this.state = {
        data: section
      };
    }
  }

  render() {
    const { data } = this.state;
    const { header } = styles;
    return (
      <WoWsInfo>
        <SuperGridSectionList itemDimension={64} sections={data}
          renderItem={({item}) => <WikiIcon item={item} onPress={() => Actions.BasicDetail({item: item})}/>}
          renderSectionHeader={({section}) => <Title style={header}>{section.title}</Title>}/>
      </WoWsInfo>
    )
  };
}

const styles = StyleSheet.create({
  header: {
    textAlign: 'center'
  }
});

export { CommanderSkill };
