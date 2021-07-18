/**
 * CommanderSkill.js
 *
 * Display commander skills in tiers
 */

import React, {Component} from 'react';
import {StyleSheet} from 'react-native';
import {SAVED, setLastLocation} from '../../value/data';
import {WoWsInfo, WikiIcon, SectionTitle} from '../../component';
import {SectionGrid} from 'react-native-super-grid';
import {SafeAction, copy} from '../../core';
import {lang} from '../../value/lang';

class CommanderSkill extends Component {
  constructor(props) {
    super(props);
    setLastLocation('CommanderSkill');
    console.log('WIKI - Commander Skill');
    let skill = DATA[SAVED.commanderSkill];
    let cloned = copy(skill);

    let section = [];
    cloned.forEach(i => {
      let index = i.tier - 1;
      // Data is sorted so we wont need to worry about not in order
      if (!section[index])
        section.push({title: `${lang.wiki_skills_tier} ${i.tier}`, data: []});
      section[index].data.push(Object.assign(i));
    });

    this.state = {
      data: section,
      point: 19,
    };
  }

  render() {
    const {data, point} = this.state;

    return (
      <WoWsInfo
        title={`${point} ${lang.wiki_skills_point}`}
        onPress={() => this.reset()}>
        <SectionGrid
          itemDimension={80}
          sections={data}
          renderItem={({item}) => {
            return (
              <WikiIcon
                item={item}
                selected={item.selected}
                onPress={() => this.skillSelected(item)}
                onLongPress={() => SafeAction('BasicDetail', {item: item})}
              />
            );
          }}
          renderSectionHeader={({section}) => (
            <SectionTitle title={section.title} />
          )}
        />
      </WoWsInfo>
    );
  }

  skillSelected(item) {
    const {point} = this.state;
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
    const {data} = this.state;
    data.forEach(i => {
      i.data.forEach(j => delete j.selected);
    });
    this.setState({point: 19, data: data});
  }
}

const styles = StyleSheet.create({
  header: {
    textAlign: 'center',
  },
});

export {CommanderSkill};
