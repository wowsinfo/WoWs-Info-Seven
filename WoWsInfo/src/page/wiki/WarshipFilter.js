/**
 * WarshipFilter.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, FlatList, ScrollView, StyleSheet } from 'react-native';
import { Surface, Text, TextInput, List, Checkbox, Button, Divider } from 'react-native-paper';
import { WoWsInfo, Touchable, DividerPlus } from '../../component';
import lang from '../../value/lang';
import { SAVED } from '../../value/data';
import { getTierList } from '../../core';

class WarshipFilter extends Component {
  constructor(props) {
    super(props);
    this.state = {
      premium: false,
    };
  }

  render() {
    const { container } = styles;
    const { premium } = this.state;

    let tierList = getTierList();

    let nations = DATA[SAVED.encyclopedia].ship_nations;
    let nationList = [];
    Object.keys(nations).forEach(k => nationList.push(nations[k]));

    let types = DATA[SAVED.encyclopedia].ship_types;
    let typeList = [];
    Object.keys(types).forEach(k => typeList.push(types[k]));

    return (
      <WoWsInfo>
        <ScrollView>
          <TextInput />
          <List.Item title={lang.wiki_warship_filter_premium} onPress={() => this.setState({premium: !premium})}
            right={() => <Checkbox status={premium ? 'checked' : 'unchecked'}/>}/>
          <List.Section title={lang.wiki_warship_filter_tier}>
            <FlatList data={tierList} renderItem={({item}) => this.renderButton(item)}
              numColumns={5} keyExtractor={item => item}/>
          </List.Section>
          <List.Section title={lang.wiki_warship_filter_nation}>
            <FlatList data={nationList} renderItem={({item}) => this.renderButton(item)}
              numColumns={3} keyExtractor={item => item}/>
          </List.Section> 
          <List.Section title={lang.wiki_warship_filter_type}>
            <FlatList data={typeList} renderItem={({item}) => this.renderButton(item)}
              numColumns={2} keyExtractor={item => item}/>
          </List.Section>
          <DividerPlus />
          <Button>{lang.wiki_warship_reset_btn}</Button>
          <Button>{lang.wiki_warship_filter_btn}</Button>
        </ScrollView>
      </WoWsInfo>
    )
  };

  renderButton(item, event) {
    return (
      <Button>{item}</Button>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export { WarshipFilter };
