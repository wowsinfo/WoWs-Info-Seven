import React, {Component} from 'react';
import {View, ScrollView, StyleSheet, Linking} from 'react-native';
import {Text, IconButton, Title, Button} from 'react-native-paper';
import {
  LoadingIndicator,
  WoWsInfo,
  FooterPlus,
  TabButton,
  InfoLabel,
  SectionTitle,
  PlayerRecord,
  DetailedInfo,
  RatingButton,
} from '../../component';
import {
  SafeFetch,
  Guard,
  humanTimeString,
  SafeAction,
  SafeStorage,
  getOverallRating,
  currDeviceWidth,
} from '../../core';
import {WoWsAPI} from '../../value/api';
import {getDomain, getPrefix, LOCAL, setLastLocation} from '../../value/data';
import {TintColour} from '../../value/colour';
import {lang} from '../../value/lang';

class Statistics extends Component {
  constructor(props) {
    super(props);
    setLastLocation('Statistics');
    let ID = Guard(props, 'info.account_id', null);
    // ID must be valid
    if (ID != null && ID !== '') {
      const {account_id, nickname, server} = props.info;
      // Check if this player is inside friend list
      let friend = DATA[LOCAL.friendList];
      let master = DATA[LOCAL.userInfo];
      console.log(master, account_id);
      this.state = {
        name: nickname,
        id: account_id,
        server: server,
        // Valid data or hidden account
        valid: true,
        hidden: false,
        // Master account
        canBeMaster: master.account_id != account_id,
        // Add to friend
        canBeFriend: friend.player[account_id] == null,
        clan: '',
        currRank: 0,
        rating: 0,
        // To check if certain data have been loaded correctly
        achievement: false,
        rank: false,
        rankShip: false,
        ship: false,
        basic: false,
        graph: false,
        // Whether show everything
        showMore: false,
      };

      // Save domain
      this.domain = getDomain(server);
      this.prefix = getPrefix(server);
      console.log(this.domain);
      // Save theme colour
      this.theme = TintColour()[500];

      if (this.domain != null) {
        this.getBasic();
        this.getRank();
        this.getClan();
        this.getShip();
        this.getAchievement();
      } else {
        // Invalid domain
        this.setState({valid: false});
      }
    } else {
      this.state = {
        id: null,
        valid: false,
      };
    }
  }

  /**
   * Get basic player info
   */
  getBasic() {
    const {server, id} = this.state;
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
    const {id} = this.state;
    SafeFetch.get(WoWsAPI.PlayerClan, this.domain, id).then(data => {
      let tag = Guard(data, `data.${id}.clan.tag`, '');
      if (tag !== '') {
        this.setState({clan: tag});
      }
    });
  }

  /**
   * Get player achievement
   */
  getAchievement() {
    const {id} = this.state;
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
    const {id} = this.state;
    // Get current rank info
    SafeFetch.get(WoWsAPI.RankInfo, this.domain, id).then(data => {
      let rank = Guard(data, `data.${id}.seasons`, null);
      if (rank != null) {
        let keys = Object.keys(rank);
        if (keys.length > 0) {
          let last = keys.slice(-1)[0];
          let currRank = Guard(rank[last], 'rank_info.rank', 0);
          if (currRank > 0) this.setState({currRank: currRank});
        }
        this.setState({rank: rank});
      }
    });

    // Get rank ship info
    SafeFetch.get(WoWsAPI.RankShipInfo, this.domain, id).then(data => {
      console.log(data);
      let ships = Guard(data, `data.${id}`, null);
      if (ships != null) {
        let formatted = {};
        for (let ship of ships) {
          const {seasons, ship_id} = ship;
          for (let season in seasons) {
            // Init if not already
            if (formatted[season] == null) formatted[season] = [];
            // Put this ship inside
            let curr = seasons[season];
            // TO make there is data there
            const {rank_solo, rank_div2, rank_div3} = curr;
            if (rank_solo) {
              curr.pvp = curr.rank_solo;
              delete curr.rank_solo;
            } else if (rank_div2) {
              curr.pvp = curr.rank_div2;
              delete curr.rank_div2;
            } else if (rank_div3) {
              curr.pvp = curr.rank_div3;
              delete curr.rank_div3;
            } else continue;

            curr.ship_id = ship_id;
            formatted[season].push(curr);
          }
        }

        this.setState({rankShip: formatted});
      }
    });
  }

  /**
   * Get all player ship info
   */
  getShip() {
    const {id} = this.state;
    SafeFetch.get(WoWsAPI.ShipInfo, this.domain, id).then(data => {
      let ship = Guard(data, `data.${id}`, null);
      console.log(ship);
      if (ship != null) {
        // Calculate personal rating for each ship and get an overall rating for this player
        let rating = getOverallRating(ship);
        this.setState({ship: ship, rating: rating, graph: ship});
      }
    });
  }

  render() {
    const {error, container, footer} = styles;
    const {name, id, valid, achievement, rank, rankShip, basic, ship, graph} =
      this.state;

    console.log(this.state);
    if (id == null || id === '') {
      // Show an error page or if it is from home, ask user to add an account first
      return (
        <WoWsInfo style={error}>
          <Text>BUG</Text>
        </WoWsInfo>
      );
    } else if (!valid) {
      // Not valid (API or Internet error)
      return (
        <WoWsInfo style={container}>
          <Text>{'Data is not valid\nPlease try again later'}</Text>
        </WoWsInfo>
      );
    } else {
      // Display player data
      return (
        <WoWsInfo
          style={container}
          title={`- ${id} -`}
          onPress={() =>
            Linking.openURL(
              `https://${this.prefix}.wows-numbers.com/player/${id},${name}/`,
            )
          }>
          <ScrollView>{this.renderBasic(basic)}</ScrollView>
          <FooterPlus style={footer}>
            {this.renderAchievement(achievement)}
            {this.renderGraph(graph)}
            {this.renderShip(ship)}
            {this.renderRank(rank, rankShip)}
          </FooterPlus>
        </WoWsInfo>
      );
    }
  }

  ///
  // I will do parallel data loading so each of them will have
  // their own state to check if the button could be rendered
  ///

  renderBasic(basic) {
    const {container, horizontal, playerName, level} = styles;
    if (!basic) {
      const {name} = this.state;
      return (
        <View style={container}>
          <Title style={playerName}>{name}</Title>
          <LoadingIndicator />
        </View>
      );
    } else {
      const {created_at, leveling_tier, last_battle_time, nickname} = basic;
      const {hidden, clan, currRank, canBeFriend, canBeMaster, rating} =
        this.state;

      let register = humanTimeString(created_at);
      let lastBattle = humanTimeString(last_battle_time);
      if (hidden) {
        return (
          <View style={container}>
            <View style={horizontal}>
              <SectionTitle title={nickname} style={playerName} />
              <IconButton
                icon="https"
                size={24}
                style={{alignSelf: 'center'}}
              />
            </View>
            <View style={styles.hidden}>
              {canBeFriend ? (
                <Button icon="contacts" onPress={this.addFriend}>
                  {lang.basic_add_friend}
                </Button>
              ) : null}
              <InfoLabel
                left
                title={lang.basic_register_date}
                info={register}
              />
              <InfoLabel
                left
                title={lang.basic_last_battle}
                info={lastBattle}
              />
              <InfoLabel
                left
                title={lang.basic_level_tier}
                info={lang.basic_data_unknown}
              />
            </View>
          </View>
        );
      } else {
        let name = nickname;
        if (clan !== '') name = `[${clan}]\n${nickname}`;
        let extraInfo = `Lv ${leveling_tier}`;
        if (currRank > 0) extraInfo += ` | ⭐${currRank}`;
        return (
          <View style={container}>
            <Title style={playerName}>{name}</Title>
            <Text style={level}>{extraInfo}</Text>
            <View style={horizontal}>
              <InfoLabel title={lang.basic_register_date} info={register} />
              <InfoLabel title={lang.basic_last_battle} info={lastBattle} />
            </View>
            <RatingButton rating={rating} />
            <View style={{padding: 4}}>
              {canBeFriend ? (
                <Button icon="contacts" onPress={this.addFriend}>
                  {lang.basic_add_friend}
                </Button>
              ) : null}
              {canBeMaster ? (
                <Button icon="heart" onPress={this.setMainAccount}>
                  {lang.basic_set_main}
                </Button>
              ) : null}
            </View>
            {this.renderStatistics(basic.statistics)}
          </View>
        );
      }
    }
  }

  getPlayerInfo() {
    const {account_id, nickname, server} = this.props.info;
    return {nickname: nickname, account_id: account_id, server: server};
  }

  setMainAccount = () => {
    let info = this.getPlayerInfo();
    DATA[LOCAL.userInfo] = info;
    SafeStorage.set(LOCAL.userInfo, info);
    this.setState({canBeMaster: false});
  };

  addFriend = () => {
    let info = this.getPlayerInfo();

    // Update object
    let str = LOCAL.friendList;
    DATA[str].player[info.account_id] = info;

    SafeStorage.set(str, DATA[str]);
    this.setState({canBeFriend: false});
  };

  renderStatistics(statistics) {
    if (!statistics) return null;
    const {showMore} = this.state;
    return (
      <View style={{paddingBottom: 8}}>
        <DetailedInfo data={statistics} more={showMore} />
        <PlayerRecord data={statistics.pvp} />
      </View>
    );
  }

  renderAchievement(achievement) {
    let loading = true;
    if (achievement && Object.keys(achievement).length > 0) loading = false;
    return (
      <TabButton
        icon={require('../../img/AchievementTab.png')}
        color={this.theme}
        disabled={loading}
        onPress={() => SafeAction('PlayerAchievement', {data: achievement})}
      />
    );
  }

  renderShip(ship) {
    let loading = true;
    if (ship && ship.length > 0) loading = false;

    return (
      <TabButton
        icon={require('../../img/Ship.png')}
        color={this.theme}
        disabled={loading}
        onPress={() => SafeAction('PlayerShip', {data: ship}, 1)}
      />
    );
  }

  renderRank(rank, rankShip) {
    let loading = true;
    if (rank && rankShip) loading = false;

    return (
      <TabButton
        icon={require('../../img/Rank.png')}
        color={this.theme}
        disabled={loading}
        onPress={() => SafeAction('Rank', {data: rank, ship: rankShip})}
      />
    );
  }

  renderGraph(graph) {
    let loading = true;
    if (graph && graph.length > 0) loading = false;
    const {hidden} = this.state;

    return (
      <TabButton
        icon={require('../../img/Graph.png')}
        color={this.theme}
        disabled={loading || hidden}
        onPress={() => SafeAction('Graph', {data: graph})}
      />
    );
  }
}

const styles = StyleSheet.create({
  error: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  hiddenProfile: {},
  container: {
    flex: 1,
  },
  horizontal: {
    flexDirection: 'row',
  },
  playerName: {
    alignSelf: 'center',
    fontSize: 32,
    fontWeight: '500',
    paddingTop: 32,
    paddingBottom: 8,
    textAlign: 'center',
  },
  level: {
    alignSelf: 'center',
    textAlign: 'center',
  },
  hidden: {
    paddingLeft: 16,
    alignItems: 'flex-start',
  },
  footer: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
});

export {Statistics};
