/**
 * WarshipFilter.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, FlatList, ScrollView, StyleSheet } from 'react-native';
import { Surface, Text, TextInput, List, Checkbox, Button, Divider } from 'react-native-paper';
import { WoWsInfo, Touchable, DividerPlus, FooterPlus, Space } from '../../component';
import lang from '../../value/lang';
import { SAVED } from '../../value/data';
import { getTierList } from '../../core';

class WarshipFilter extends Component {
  constructor(props) {
    super(props);

    this.state = {
      premium: false,
      name: '',
      nation: [],
      type: [],
      tier : []
    };
  }

  componentDidMount() {
    // After component has been rendered or it will be undefined
    this.refs['scrollview'].scrollTo({x: 0, y: 128, animated: true});
  }

  render() {
    const { horizontal, button } = styles;
    const { premium } = this.state;

    let tierList = getTierList();

    let nations = DATA[SAVED.encyclopedia].ship_nations;
    let nationList = [];
    Object.keys(nations).forEach(k => nationList.push(nations[k]));

    let types = DATA[SAVED.encyclopedia].ship_types;
    let typeList = [];
    Object.keys(types).forEach(k => typeList.push(types[k]));

    return (
      <WoWsInfo title={lang.wiki_warship_filter_placeholder} onPress={() => this.refs['search'].focus()}>
        <TextInput label={lang.wiki_warship_filter_placeholder} ref='search' theme={{roundness: 0}}/>
        <ScrollView ref='scrollview'>
          <Space />
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
          <Space />
        </ScrollView>
        <FooterPlus>
          <List.Item title={lang.wiki_warship_filter_premium} onPress={() => this.setState({premium: !premium})}
            right={() => <Checkbox status={premium ? 'checked' : 'unchecked'}/>}/>
          <View style={horizontal}>
            <Button style={button} onPress={this.resetAll}>{lang.wiki_warship_reset_btn}</Button>
            <Button style={button}>{lang.wiki_warship_filter_btn}</Button>
          </View>
        </FooterPlus>
      </WoWsInfo>
    )
  };

  resetAll = () => this.setState({
    premium: false,
    name: '',
    nation: [],
    type: [],
    tier : []
  });

  renderButton(item, event) {
    return (
      <Button>{item}</Button>
    )
  }
}

const styles = StyleSheet.create({
  horizontal: {
    flexDirection: 'row'
  },
  button: {
    flex: 1
  }
});

export { WarshipFilter };
