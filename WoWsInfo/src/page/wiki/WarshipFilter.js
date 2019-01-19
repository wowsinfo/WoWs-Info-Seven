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
import { Actions } from 'react-native-router-flux';

const MODE = {
  TIER: 1,
  NATION: 2,
  TYPE: 3,
};

class WarshipFilter extends Component {
  constructor(props) {
    super(props);
    console.log(props);
    
    this.state = {
      premium: false,
      name: '',
      nation: new Array(0),
      type: new Array(0),
      tier: new Array(0)
    };
  }
  
  componentDidMount() {
    // After component has been rendered or it will be undefined
    this.refs['scrollview'].scrollTo({x: 0, y: 128, animated: true});
  }
  
  render() {
    const { horizontal, button, selectionText } = styles;
    const { premium, name, nation, type, tier } = this.state;

    let tierList = getTierList();

    let nations = DATA[SAVED.encyclopedia].ship_nations;
    let nationList = [];
    Object.keys(nations).forEach(k => nationList.push(nations[k]));

    let types = DATA[SAVED.encyclopedia].ship_types;
    let typeList = [];
    Object.keys(types).forEach(k => typeList.push(types[k]));

    return (
      <WoWsInfo title={lang.wiki_warship_filter_placeholder} onPress={() => this.refs['search'].focus()}>
        <TextInput label={lang.wiki_warship_filter_placeholder} ref='search' autoCorrect={false}
          theme={{roundness: 0}} onChangeText={t => this.setState({name: t})} onEndEditing={() => {
            // Do not go back if it is still empty
            if (name.trim(' ').length > 0) this.applyAll();
          }} clearButtonMode='while-editing' autoCapitalize='none'/>
        <ScrollView ref='scrollview'>
          <Space />
          <List.Section title={lang.wiki_warship_filter_tier}>
            <Text style={selectionText}>{`${tier.join(' | ')} `}</Text>
            <FlatList data={tierList} numColumns={5} keyExtractor={item => item}
              renderItem={({item}) => this.renderButton(item, () => this.addData(item, MODE.TIER))}/>
          </List.Section>
          <List.Section title={lang.wiki_warship_filter_nation}>
            <Text style={selectionText}>{`${nation.join(' | ')} `}</Text>
            <FlatList data={nationList} numColumns={3} keyExtractor={item => item}
              renderItem={({item}) => this.renderButton(item, () => this.addData(item, MODE.NATION))}/>
          </List.Section> 
          <List.Section title={lang.wiki_warship_filter_type}>
            <Text style={selectionText}>{`${type.join(' | ')} `}</Text>
            <FlatList data={typeList} numColumns={2} keyExtractor={item => item}
              renderItem={({item}) => this.renderButton(item, () => this.addData(item, MODE.TYPE))}/>
          </List.Section>
          <Space />
        </ScrollView>
        <FooterPlus>
          <List.Item title={lang.wiki_warship_filter_premium} onPress={() => this.setState({premium: !premium})}
            right={() => <Checkbox status={premium ? 'checked' : 'unchecked'}/>}/>
          <View style={horizontal}>
            <Button style={button} onPress={this.resetAll}>{lang.wiki_warship_reset_btn}</Button>
            <Button style={button} onPress={this.applyAll}>{lang.wiki_warship_filter_btn}</Button>
          </View>
        </FooterPlus>
      </WoWsInfo>
    )
  }

  resetAll = () => this.setState({
    premium: false,
    name: '',
    nation: [],
    type: [],
    tier : []
  });

  applyAll = () => {
    Actions.popTo('Warship');
    setTimeout(() => {
      Actions.refresh({filter: Object.assign(this.state)});
    })
  };

  renderButton(item, event) {
    return (
      <Button onPress={event}>{item}</Button>
    )
  }

  addData(item, mode) {
    const { tier, nation, type } = this.state;
    let arr = null;
    switch (mode) {
      case MODE.TIER: arr = tier; break;
      case MODE.NATION: arr = nation; break;
      case MODE.TYPE: arr = type; break;
    }

    // Same as last added item
    if (arr.slice(-1)[0] === item) return;
    arr.push(item);

    switch (mode) {
      case MODE.TIER: this.setState({tier: arr}); break;
      case MODE.NATION: this.setState({nation: arr}); break;
      case MODE.TYPE: this.setState({type: arr}); break;
    }
  }
}

const styles = StyleSheet.create({
  horizontal: {
    flexDirection: 'row'
  },
  button: {
    flex: 1
  },
  selectionText: {
    paddingLeft: 16,
    paddingRight: 16 
  }
});

export { WarshipFilter };
