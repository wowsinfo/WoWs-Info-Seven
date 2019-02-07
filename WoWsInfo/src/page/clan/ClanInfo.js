/**
 * ClanInfo.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Text, Linking, StyleSheet } from 'react-native';
import { WoWsInfo } from '../../component';
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
      info: false
    };

    this.domain = getDomain(server);
    this.prefix = getPrefix(server);

    SafeFetch.get(WoWsAPI.ClanInfo, this.domain, clan_id).then(data => {
      let clanInfo = Guard(data, `data.${clan_id}`, null);
      if (clanInfo != null) {
        this.setState({info: clanInfo});
      }
    });
  }

  render() {
    const { container } = styles;
    const { info, tag, id } = this.state;
    return (
      <WoWsInfo title={`- ${id} -`} onPress={() => Linking.openURL(`https://${this.prefix}.wows-numbers.com/clan/${id}, ${tag}/`)}>
        <Title>{tag}</Title>
      </WoWsInfo>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export { ClanInfo };
