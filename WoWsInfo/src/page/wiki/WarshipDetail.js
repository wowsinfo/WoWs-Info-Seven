/**
 * WarshipDetail.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, FlatList, Linking, ScrollView, StyleSheet } from 'react-native';
import { Text, Title, Subheading, Headline, Button, Surface, Paragraph } from 'react-native-paper';
import { WoWsInfo, WikiIcon, WarshipCell, LoadingModal } from '../../component';
import { SAVED, SERVER, LOCAL } from '../../value/data';
import lang from '../../value/lang';
import { SafeFetch, langStr, Guard } from '../../core';
import { WoWsAPI } from '../../value/api';

class WarshipDetail extends Component {
  constructor(props) {
    super(props);

    this.server = SERVER[DATA[LOCAL.userServer]];

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
      similar: similar,
      loading: true,
      data: {}
    };
  }

  componentWillMount() {
    // Start loading data here
    this.requestData(this.props.item.ship_id);
  }

  render() {
    const { curr, loading, similar } = this.state;
    if (curr) {
      return (
        <WoWsInfo title={curr.ship_id}>
            <ScrollView style={{flex: 1}}>
              { this.renderContent() }
            </ScrollView> 
          { this.renderSimilar(similar) }
        </WoWsInfo>
      )
    } else {
      // Bug here
    }
  };

  renderContent() {
    const { curr, loading, data } = this.state;
    if (loading) {
      return <LoadingModal />
    } else {
      return (
        <Surface>
          <WikiIcon warship item={curr} scale={3}/>
          { this.renderBasic(curr, data) }
          { this.renderAll(data) }
        </Surface>
      )
    }
  }

  renderBasic(curr, data) {
    const { container, shipTitle } = styles;
    const { name, model, type, nation } = curr;
    const { description } = this.state.data;

    return (
      <View style={container}>
        <Title style={shipTitle}>{name}</Title>
        <Text>{nation.toUpperCase()}</Text>
        <Text>{type}</Text>
        { model ? <Button onPress={() => Linking.openURL(`https://sketchfab.com/models/${model}/embed?autostart=1&preload=1`)}>{lang.warship_model}</Button> : null }
        <Paragraph>{description}</Paragraph>
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
              this.setState({curr: item, loading: true}, 
                () => this.requestData(item.ship_id));
            }}/>
          }}/>
        </View>
      )
    } else return null;
  }

  async requestData(id) {
    let json = await SafeFetch.get(WoWsAPI.ShipWiki, this.server, id, langStr());
    let data = Guard(json, 'data', {});

    console.log(data);
    this.setState({data: data[id], loading: false});
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
