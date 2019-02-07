import React, { PureComponent } from 'react';
import { View, ScrollView, StyleSheet, Linking } from 'react-native';
import { Surface, Text, IconButton, Title, Button } from 'react-native-paper';
import { LoadingIndicator, WoWsInfo, LoadingModal, FooterPlus, TabButton, InfoLabel, SectionTitle, ShipStat, PlayerRecord } from '../../component';
import { SafeFetch, Guard, dayDifference, humanTimeString, SafeAction, SafeStorage } from '../../core';
import { WoWsAPI } from '../../value/api';
import { getDomain, langStr, getPrefix, LOCAL } from '../../value/data';
import { TintColour } from '../../value/colour';
import lang from '../../value/lang';

class Statistics extends PureComponent {
  constructor(props) {
    super(props);
    const { account_id, nickname, server } = props.info;

    // Check if this player is inside friend list
    let friend = DATA[LOCAL.friendList];
    let master = DATA[LOCAL.userInfo];

    this.state = {
      name: nickname,
      id: account_id,
      server: server,
      // Valid data or hidden account
      valid: true,
      hidden: false,
      // Master account
      canBeMaster: master.account_id !== account_id,
      // Add to friend
      canBeFriend: friend.findIndex(f => f.account_id === account_id) === -1,
      clan: '',
      currRank: 0,
      // To check if certain data have been loaded correctly
      achievement: false,
      rank: false,
      ship: false,
      basic: false,
      graph: false,
      // Whether show everything
      showMore: false
    };

    // Save domain
    this.domain = getDomain(server);
    this.prefix = getPrefix(server);
    console.log(this.domain);
    // Save theme colour
    this.theme = TintColour()[500];

    if (this.domain != null) {
      this.getBasic();
      this.getClan();
      this.getCurrRank();
      this.getAchievement();
      // this.getShip();
      // this.getRank();
    } else {
      // Invalid domain
      this.setState({valid: false});
    }
  }

  /**
   * Get basic player info
   */
  getBasic() {
    const { server, id } = this.state;
    SafeFetch.get(WoWsAPI.PlayerInfo, getDomain(server), id).then(data => {
      // Check if account is hidden
      console.log(data);
      let hidden = Guard(data, 'meta.hidden', null);
      let hiddenAccount = false;
      if (hidden != null) {
        // If hidden is not null, it is hidden
        hiddenAccount = true;
        this.setState({hidden: true});
      }

      // Get player data here
      let player = Guard(data, `data.${id}`, null);
      if (player == null) {
        // Invalid data
        this.setState({valid: false});
      } else {
        let battle = Guard(player, 'statistics.pvp.battles', 0);
        // Treat zero battle account as hidden not for hidden accounts
        if (!hiddenAccount && battle == 0) this.setState({hidden: true});
        this.setState({basic: player});
      }
    });
  }

  getClan() {
    const { id } = this.state;
    SafeFetch.get(WoWsAPI.PlayerClan, this.domain, id).then(data => {
      let tag = Guard(data, `data.${id}.clan.tag`, '');
      if (tag !== '') {
        this.setState({clan: tag});
      }
    });
  }

  getCurrRank() {
    const { id } = this.state;
    SafeFetch.get(WoWsAPI.CurrRankInfo, this.domain, id).then(data => {
      let seasons = Guard(data, `data.${id}.seasons`, null);
      if (seasons != null) {
        let keys = Object.keys(seasons);
        if (keys.length > 0) {
          let last = keys.slice(-1)[0];
          let currRank = Guard(seasons[last], 'rank_info.rank', 0);
          if (currRank > 0) this.setState({currRank: currRank});
        }
      }
    });
  }

  /**
   * Get player achievement
   */
  getAchievement() {
    const { id } = this.state;
    SafeFetch.get(WoWsAPI.PlayerAchievement, this.domain, id).then(data => {
      let achievement = Guard(data, `data.${id}.battle`, null);
      if (achievement != null) {
        this.setState({achievement: achievement});
      }
    });
  }

  /**
   * Get player past rank info
   */
  getRank() {
    const { id } = this.state;
    SafeFetch.get(WoWsAPI.RankInfo, this.domain, id).then(data => {
      let rank = Guard(data, `data.${id}.seasons`, null);
      if (rank != null) {
        this.setState({rank: rank});
      }
    });
  }

  /**
   * Get all player ship info
   */
  getShip() {
    const { id } = this.state;
    SafeFetch.get(WoWsAPI.ShipInfo, this.domain, id).then(data => {
      let ship = Guard(data, `data.${id}`, null);
      if (ship != null) {
        this.setState({ship: ship});
      }
    });
  }

  render() {
    const { error, container, footer } = styles;
    const { home, friend } = this.props;
    const { name, id, valid, 
            achievement, rank, basic, ship, graph } = this.state;

    console.log(this.state);
    let RootView = home ? Surface : WoWsInfo;
    if (id == null || id == "") {
      // Show an error page or if it is from home, ask user to add an account first
      return (
        <RootView style={error}>
          {
            home ? <Text>Add yourself first</Text>
            : <Text>BUG</Text>
          }
        </RootView>
      );
    } else if (!valid) {
      // Not valid (API or Internet error)
      return (
        <RootView style={container}>
          <Text>{'Data is not valid\nPlease try again later'}</Text>
        </RootView>
      );
    } else {
      // Display player data
      return (
        <RootView noLeft={friend} title={`- ${id} -`} 
          onPress={() => Linking.openURL(`https://${this.prefix}.wows-numbers.com/player/${id},${name}/`)}>
          <ScrollView>
            { this.renderBasic(basic) }
          </ScrollView>
          <FooterPlus style={footer}>
            { this.renderAchievement(achievement) }
            { this.renderGraph(graph) }
            { this.renderShip(ship) }
            { this.renderRank(rank) }
          </FooterPlus>
        </RootView>
      );
    }

  };

  ///
  // I will do parallel data loading so each of them will have 
  // their own state to check if the button could be rendered
  ///

  renderBasic(basic) {
    const { container, horizontal, playerName, level } = styles;
    if (!basic) {
      const { name } = this.state;
      return (
        <View style={container}>
          <Title style={playerName}>{name}</Title>
          <LoadingIndicator />
        </View>
      )
    } else {
      const { created_at, leveling_tier, last_battle_time, nickname } = basic;
      const { hidden, clan, currRank } = this.state;
      let register = humanTimeString(created_at);
      let lastBattle = humanTimeString(last_battle_time)
      if (hidden) {
        return (
          <View style={container}>
            <View style={horizontal}>
              <SectionTitle title={nickname} style={playerName}/>
              <IconButton icon='https' size={24} />
            </View>
            <View style={styles.hidden}>
              <InfoLabel left title={lang.basic_register_date} info={register}/>
              <InfoLabel left title={lang.basic_last_battle} info={lastBattle}/>
              <InfoLabel left title={lang.basic_level_tier} info={lang.basic_data_unknown}/>
            </View>
          </View>
        )
      } else {
        let name = nickname;
        if (clan !== '') name = `[${clan}]\n${nickname}`;
        let extraInfo = `Lv ${leveling_tier}`;
        if (currRank > 0) extraInfo += ` | ⭐${currRank}`;
        const { canBeFriend, canBeMaster } = this.state;
        return (
          <View style={container}>
            <Title style={playerName}>{name}</Title>
            <Text style={level}>{extraInfo}</Text>
            <View style={horizontal}>
              <InfoLabel title={lang.basic_register_date} info={register}/>
              <InfoLabel title={lang.basic_last_battle} info={lastBattle}/>
            </View>
            <View style={[horizontal, {justifyContent: 'space-around'}]}>
              { canBeMaster ? <Button compact icon='favorite' onPress={this.setMainAccount}>Set as Main</Button> : null }
              { canBeFriend ? <Button compact icon='contacts' onPress={this.addFriend}>Add as friend</Button> : null }
            </View>
            { this.renderStatistics(basic.statistics) }
          </View>
        )
      }
    }
  }

  getPlayerInfo() {
    const { account_id, nickname, server } = this.props.info;
    return {nickname: nickname, account_id: account_id, server: server};
  }

  setMainAccount = () => {
    let info = this.getPlayerInfo();
    DATA[LOCAL.userInfo] = info;
    SafeStorage.set(LOCAL.userInfo, info);
    this.setState({canBeMaster: false});
  }

  addFriend = () => {
    let info = this.getPlayerInfo();
    
    let str = LOCAL.friendList;
    let friend = DATA[str];
    friend.push(info);

    DATA[str] = friend;
    SafeStorage.set(LOCAL.friendList, friend);
    this.setState({canBeFriend: false});
  }

  renderStatistics(statistics) {
    if (!statistics) return null;
    const { showMore } = this.state;
    return (
      <View>
        <ShipStat data={statistics} more={showMore}/>
        <PlayerRecord data={statistics.pvp}/>
      </View>
    )
  }

  renderAchievement(achievement) {
    let loading = true;
    if (achievement) loading = false;

    return <TabButton icon={require('../../img/AchievementTab.png')} color={this.theme}
      disabled={loading} onPress={() => SafeAction('PlayerAchievement', {data: achievement})}/>
  }

  renderShip(ship) {
    let loading = true;
    if (ship) loading = false;

    return <TabButton icon={require('../../img/Ship.png')} color={this.theme}
      disabled={loading} />  
  }

  renderRank(rank) {
    let loading = true;
    if (rank) loading = false;

    return <TabButton icon={require('../../img/Rank.png')} color={this.theme}
      disabled={loading} />
  }

  renderGraph(graph) {
    const { hidden } = this.state;
    return <TabButton icon={require('../../img/Graph.png')} color={this.theme}
      disabled={true} />
  }
}

const styles = StyleSheet.create({
  error: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  container: {
    flex: 1,
  },
  horizontal: {
    flexDirection: 'row'
  },
  playerName: {
    alignSelf: 'center',
    fontSize: 32,
    fontWeight: '500',
    marginTop: 32,
    textAlign: 'center'
  },
  level: {
    alignSelf: 'center',
    textAlign: 'center'
  },
  hidden: {
    paddingLeft: 16,
    alignItems: 'flex-start'
  },
  footer: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
});

export { Statistics };
