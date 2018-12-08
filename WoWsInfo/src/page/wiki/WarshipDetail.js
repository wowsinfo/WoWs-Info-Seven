/**
 * WarshipDetail.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, FlatList, Linking, ScrollView, StyleSheet } from 'react-native';
import { Text, Title, Subheading, Headline, Button } from 'react-native-paper';
import { WoWsInfo, WikiIcon, WarshipCell } from '../../component';
import { SAVED } from '../../value/data';
import lang from '../../value/lang';

class WarshipDetail extends Component {
  constructor(props) {
    super(props);

    let curr = props.item;
    console.log(curr);

    // Get all other same tier and same type ships
    let warship = DATA[SAVED.warship];
    let similar = Object.entries(warship).filter(s => {
      if (s[1].tier === curr.tier && s[1].type === curr.type) return true;
    });

    // Remove extra information (ship id)
    similar.forEach((s, i) => similar[i] = Object.assign(s[1]));
    console.log(similar);

    this.state = {
      curr: props.item,
      similar: similar
    };
  }

  render() {
    const { curr, similar } = this.state;
    if (curr) {
      return (
        <WoWsInfo title={curr.ship_id}>
          <ScrollView>
            <WikiIcon warship item={curr} scale={3}/>
            { this.renderBasic(curr) }
            { this.renderAll(curr) }
          </ScrollView>
          { this.renderSimilar(similar) }
        </WoWsInfo>
      )
    } 
  };

  renderBasic(curr) {
    const { container, shipTitle } = styles;
    const { ship_id, name, model, type, nation } = curr;
    return (
      <View style={container}>
        <Title style={shipTitle}>{name}</Title>
        <Text>{nation.toUpperCase()}</Text>
        <Text>{type}</Text>
        { model ? <Button onPress={() => Linking.openURL(`https://sketchfab.com/models/${model}/embed?autostart=1&preload=1`)}>{lang.warship_model}</Button> : null }
      </View>
    )
  }

  renderAll(curr) {

  }

  /**
   * Do not render when there are no similar ships...
   * @param {*} similar 
   */
  renderSimilar(similar) {
    const { curr } = this.state;
    if (Object.keys(similar).length > 0) {
      return (
        <View style={{height: 76}}>
          <FlatList keyExtractor={item => item.name} horizontal data={similar} renderItem={({item}) => {
            return <WarshipCell item={item} scale={1.4} onPress={() => {
              if (item.ship_id === curr.ship_id) return;
              this.setState({curr: item});
            }}/>
          }}/>
        </View>
      )
    } else return null;
  }

  requestData(id) {

  }
}

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center'
  },
  shipTitle: {
    fontSize: 24,
    marginBottom: 16
  }
});

export { WarshipDetail };
