/**
 * WarshipDetail.js
 * 
 * 
 */

import React, { PureComponent } from 'react';
import { View, FlatList, ActivityIndicator,Linking, ScrollView, StyleSheet } from 'react-native';
import { Text, Title, Subheading, Headline, Button, Surface, Paragraph, List } from 'react-native-paper';
import { WoWsInfo, WikiIcon, WarshipCell, LoadingModal, PriceLabel } from '../../component';
import { SAVED, SERVER, LOCAL } from '../../value/data';
import lang from '../../value/lang';
import { SafeFetch, langStr, Guard } from '../../core';
import { WoWsAPI } from '../../value/api';

class WarshipDetail extends PureComponent {
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

    this.delayedRequest = null;
  }

  componentWillMount() {
    // Start loading data here
    this.requestData(this.props.item.ship_id);
  }

  render() {
    const { curr, similar } = this.state;
    if (curr) {
      return (
        <WoWsInfo title={`${curr.ship_id_str} ${curr.ship_id}`}>
          <ScrollView style={{flex: 1}}>
            <WikiIcon warship item={curr} scale={3}/>
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
      return <ActivityIndicator />
    } else {
      return (
       <View>
        { this.renderBasic(curr, data) }
        { this.renderAll(data) }
       </View>
      )
    }
  }

  renderBasic(curr, data) {
    const { container, shipTitle, centerText, modelBtn } = styles;
    const { name, model, type, nation } = curr;
    const { description } = data;

    return (
      <View style={container}>
        <Title style={shipTitle}>{name}</Title>
        <Text>{nation.toUpperCase()}</Text>
        <Text>{type}</Text>
        <PriceLabel item={data}/>
        { model ? <Button style={modelBtn} onPress={() => Linking.openURL(`https://sketchfab.com/models/${model}/embed?autostart=1&preload=1`)}>
          {lang.warship_model}
        </Button> : null }
        <Paragraph style={centerText}>{description}</Paragraph>
      </View>
    )
  }

  renderAll(curr) {
    const { default_profile, modules_tree, modules, next_ships } = curr;
    return (
      <View>
        <List.Accordion title='Hello'>
        </List.Accordion>
        <List.Accordion title='Hello'>
        </List.Accordion>
        <List.Accordion title='Hello'>
        </List.Accordion>
        <List.Accordion title='Hello'>
        </List.Accordion>
        <List.Accordion title='Hello'>
        </List.Accordion>
      </View>
    )
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
              this.setState({curr: item, loading: true}, 
                () => this.efficientDataRequest(item.ship_id));
            }}/>
          }}/>
        </View>
      )
    } else return null;
  }

  efficientDataRequest(id) {
    clearTimeout(this.delayedRequest);
    this.delayedRequest = setTimeout(() => {
      SafeFetch.get(WoWsAPI.ShipWiki, this.server, id, langStr()).then(json => {
        let data = Guard(json, 'data', {});
        console.log(data);
        this.setState({data: data[id], loading: false});
      });
    }, 1000);
  }
}

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center'
  },
  shipTitle: {
    fontSize: 24,
    paddingBottom: 16
  },
  modelBtn: {
    marginTop: 8
  },
  centerText: {
    textAlign: 'center',
    padding: 8
  }
});

export { WarshipDetail };
