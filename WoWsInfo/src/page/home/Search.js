/**
 * Search.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Text, StyleSheet, FlatList, ScrollView } from 'react-native';
import { Searchbar } from 'react-native-paper';
import { WoWsInfo, SectionTitle, PlayerCell } from '../../component';
import { getCurrDomain, getCurrPrefix } from '../../value/data';
import { Guard, SafeFetch } from '../../core';
import { WoWsAPI } from '../../value/api';
import { Friend } from './Friend';
import { lang } from '../../value/lang';

class Search extends Component {
  constructor(props) {
    super(props);

    this.state = {
      search: '',
      server: '',
      result: {player: [], clan: []},
      online: '???',
      showFriend: true
    };

    const domain = getCurrDomain();
    // com -> na
    this.prefix = getCurrPrefix();

    SafeFetch.get(WoWsAPI.PlayerOnline, domain).then(num => {
      let online = Guard(num, 'data.wows.0.players_online', '???');
      this.setState({online: online});
    });
  }

  render() {
    const { search, online } = this.state;
    const { searchBar, scroll } = styles;
    return (
      <WoWsInfo>
        <Searchbar ref='search' value={search} style={searchBar} placeholder={`${this.prefix.toUpperCase()} - ${online} ${lang.search_player_online}`}
          onChangeText={this.searchAll} autoCorrect={false} autoCapitalize='none' 
          onFocus={() => this.setState({showFriend: true})} onBlur={() => this.setState({showFriend: false})}/>
        <ScrollView style={scroll}>
          { this.renderContent() }
        </ScrollView>
      </WoWsInfo>
    )
  }

  renderContent() {
    const { search, result, showFriend } = this.state;
    if (showFriend && search.length < 2) {
      return <Friend />;
    } else {
      let playerLen  = result.player.length;
      let clanLen  = result.clan.length;
      return (
        <View>
          <SectionTitle title={`${lang.menu_search_clan} - ${clanLen}`}/>
          { clanLen > 0 ?
            <FlatList data={result.clan} renderItem={({item}) => {
              return <PlayerCell key={item.clan_id} item={item} clan/>
            }} keyExtractor={c => c.tag} keyboardShouldPersistTaps='always'/> : null }
          <SectionTitle title={`${lang.menu_search_player} - ${playerLen}`}/>
          { playerLen > 0 ?
            <FlatList data={result.player} renderItem={({item}) => {
              return <PlayerCell key={item.account_id} item={item} player/>
            }} keyExtractor={p => p.nickname} keyboardShouldPersistTaps='always'/> : null }
        </View>
      );
    }
  }

  /**
   * Search player and clan
   */
  searchAll = (text) => {
    // Reset search
    if (text.length < 2) this.setState({result: {player: [], clan: []}});
    this.setState({search: text});

    // Clear timeout everytime for efficient data request
    clearTimeout(this.delayedRequest);
    this.delayedRequest = setTimeout(() => {
      let domain = getCurrDomain();
      // Save all clans and players
      let all = {player: [], clan: []};
      let length = text.length;
      
      if (length > 1 && length < 6) {
        // For clan, only 2 - 5
        SafeFetch.get(WoWsAPI.ClanSearch, domain, text).then(result => {
          let data = Guard(result, 'data', null);
          if (data == null) {
            // Error here
          } else {
            data.forEach(v => v.server = getCurrServer());
            all.clan = data;
            this.setState({result: all});
          }
        });
      }

      if (length > 2) {
        // For player, 3+
        SafeFetch.get(WoWsAPI.PlayerSearch, domain, text).then(result => {
          let data = Guard(result, 'data', null);
          if (data == null) {
            // Error here
          } else {
            data.forEach(v => v.server = getCurrServer());
            all.player = data;
            this.setState({result: all});
          }
        });
      }
    }, 500);
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  },
  searchBar: {
    position: 'absolute',
    zIndex: 2,
    top: 16,
    left: 16, right: 16,
    borderRadius: 100
  },
  scroll: {
    marginTop: 64
  }
});

export { Search };
