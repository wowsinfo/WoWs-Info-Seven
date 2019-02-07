/**
 * ClanInfo.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Text, ScrollView, Linking, StyleSheet } from 'react-native';
import { WoWsInfo, LoadingIndicator } from '../../component';
import { SafeFetch, Guard } from '../../core';
import { WoWsAPI } from '../../value/api';
import { getDomain, getPrefix } from '../../value/data';
import { Title } from 'react-native-paper';

class ClanInfo extends Component {
  constructor(props) {
    super(props);

    const { clan_id, tag, server } = props.info;
    this.state = {
      id: clan_id,
      tag: tag,
      info: false,
      // Clan ID must be valid
      valid: clan_id != null
    };

    this.domain = getDomain(server);
    this.prefix = getPrefix(server);

    SafeFetch.get(WoWsAPI.ClanInfo, this.domain, clan_id).then(data => {
      let clanInfo = Guard(data, `data.${clan_id}`, null);
      if (clanInfo != null) {
        this.setState({info: clanInfo});
      } else {
        this.setState({valid: false});
      }
    });
  }

  render() {
    const { clanTag, container } = styles;
    const { info, tag, id, valid } = this.state;
    if (valid) {
      return (
        <WoWsInfo title={`- ${id} -`} onPress={() => Linking.openURL(`https://${this.prefix}.wows-numbers.com/clan/${id}, ${tag}/`)}>
          <ScrollView>
            <Title style={clanTag}>{`[${tag}]`}</Title>
            { info ? <View>
    
            </View> : <LoadingIndicator /> }
          </ScrollView>
        </WoWsInfo>
      )
    } else {
      return (
        <WoWsInfo title={`- ${id} -`} style={container}>
          <Title style={clanTag}>{`[${tag}]`}</Title>
        </WoWsInfo>
      )
    }
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  },
  clanTag: {
    alignSelf: 'center',
    fontSize: 32,
    fontWeight: '500',
    paddingTop: 16,
    paddingBottom: 8,
    textAlign: 'center'
  },
});

export { ClanInfo };
