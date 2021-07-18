/**
 * Search.js
 *
 * This is the search screen to find players and clans
 */

import React, {Component} from 'react';
import {View, StyleSheet, ScrollView} from 'react-native';
import {Searchbar} from 'react-native-paper';
import * as Anime from 'react-native-animatable';
import {WoWsInfo, SectionTitle, PlayerCell} from '../../component';
import {
  getCurrDomain,
  getCurrPrefix,
  getCurrServer,
  setLastLocation,
} from '../../value/data';
import {Guard, SafeFetch, bestWidth} from '../../core';
import {WoWsAPI} from '../../value/api';
import {Friend} from './Friend';
import {lang} from '../../value/lang';
import {FlatGrid} from 'react-native-super-grid';

class Search extends Component {
  constructor(props) {
    super(props);
    setLastLocation('Search');
    this.state = {
      search: '',
      server: '',
      result: {player: [], clan: []},
      online: '???',
      showFriend: true,
      goodWidth: bestWidth(400),
    };

    const domain = getCurrDomain();
    // com -> na
    this.prefix = getCurrPrefix();

    SafeFetch.get(WoWsAPI.PlayerOnline, domain).then(num => {
      let online = Guard(num, 'data.wows.0.players_online', '???');
      this.setState({online: online});
    });
  }

  updateWidth = event => {
    const newWidth = event.nativeEvent.layout.width;
    this.setState({goodWidth: bestWidth(400, newWidth)});
  };

  render() {
    const {search, online} = this.state;
    const {searchBar, scroll} = styles;
    return (
      <WoWsInfo
        hideAds
        title={lang.menu_footer}
        onPress={() => this.refs['search'].focus()}>
        <Searchbar
          ref="search"
          value={search}
          style={searchBar}
          placeholder={`${this.prefix.toUpperCase()} - ${online} ${
            lang.search_player_online
          }`}
          onChangeText={this.searchAll}
          autoCorrect={false}
          autoCapitalize="none"
        />
        <ScrollView
          style={scroll}
          keyboardShouldPersistTaps="always"
          keyboardDismissMode="on-drag"
          onLayout={this.updateWidth}>
          {this.renderContent()}
        </ScrollView>
      </WoWsInfo>
    );
  }

  renderContent() {
    const {search, result, showFriend} = this.state;
    if (showFriend && search.length < 2) {
      return <Friend />;
    } else {
      const playerLen = result.player.length;
      const clanLen = result.clan.length;
      return (
        <View>
          <SectionTitle title={`${lang.menu_search_clan} - ${clanLen}`} />
          {this.renderClan(result.clan)}
          <SectionTitle title={`${lang.menu_search_player} - ${playerLen}`} />
          {this.renderPlayer(result.player)}
        </View>
      );
    }
  }

  /**
   *
   * @param {any[]} clan
   */
  renderClan(clan) {
    if (clan.length > 0) {
      return (
        <View style={styles.wrap}>
          {clan.map(item => (
            <PlayerCell
              key={item.clan_id}
              item={item}
              clan
              width={this.state.goodWidth}
            />
          ))}
        </View>
      );
    }

    return null;
  }

  /**
   *
   * @param {any[]} player
   */
  renderPlayer(player) {
    if (player.length > 0) {
      return (
        <View style={styles.wrap}>
          {player.map(item => (
            <PlayerCell
              key={item.account_id}
              item={item}
              player
              width={this.state.goodWidth}
            />
          ))}
        </View>
      );
    }

    return null;
  }

  /**
   * Search player and clan
   */
  searchAll = text => {
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
            data.forEach(v => (v.server = getCurrServer()));
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
            data.forEach(v => (v.server = getCurrServer()));
            all.player = data;
            this.setState({result: all});
          }
        });
      }
    }, 500);
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  searchBar: {
    position: 'absolute',
    zIndex: 2,
    top: 16,
    left: 16,
    right: 16,
    borderRadius: 100,
  },
  scroll: {
    marginTop: 64,
  },
  wrap: {
    flexDirection: 'row',
    flexWrap: 'wrap',
  },
});

export {Search};
