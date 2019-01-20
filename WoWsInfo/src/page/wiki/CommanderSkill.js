/**
 * CommanderSkill.js
 * 
 * Display commander skills in tiers
 */

import React, { Component } from 'react';
import { StyleSheet } from 'react-native';
import { Surface, Title, List } from 'react-native-paper';
import { SAVED } from '../../value/data';
import { WoWsInfo, WikiIcon } from '../../component';
import { SectionGrid } from 'react-native-super-grid';
import { Actions } from 'react-native-router-flux';
import { SafeAction } from '../../core';
import lang from '../../value/lang';
import { ThemeBackColour } from '../../value/colour';

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

    let section = [];
    data.forEach(i => {
      let index = i.tier - 1;
      // Data is sorted so we wont need to worry about not in order
      if (!section[index]) section.push({title: `Tier ${i.tier}`, data: []});
      section[index].data.push(i);
    });
    console.log(section);

    return (
      <WoWsInfo title={`${point} ${lang.wiki_skills_point}`} onPress={() => this.reset()}>
        <SectionGrid itemDimension={80} sections={section} renderItem={({item}) => {
          return <WikiIcon item={item} selected={item.selected} onPress={() => this.skillSelected(item)} 
          onLongPress={() => SafeAction('BasicDetail', {item: item})}/>
        }} renderSectionHeader={({section}) => (
          <List.Item title={section.title} style={ThemeBackColour()}/>
        )}/>
      </WoWsInfo>
    )
  };

  skillSelected(item) {
    const { point } = this.state;
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
  }

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
