import React, { PureComponent } from 'react';
import { View, SafeAreaView, Text, StyleSheet } from 'react-native';
import { Surface, Button } from 'react-native-paper';
import { LoadingIndicator, WoWsInfo, LoadingModal } from '../../component';
import { SafeFetch, Guard } from '../../core';
import { WoWsAPI } from '../../value/api';
import { getDomain, langStr } from '../../value/data';

class Statistics extends PureComponent {
  constructor(props) {
    super(props);
    const { account_id, nickname, server } = props.info;

    this.state = {
      name: nickname,
      id: account_id,
      server: server,
      data: {},
      // Valid data or hidden account
      valid: true,
      hidden: false,
      // To check if certain data have been loaded correctly
      achievement: false,
      rank: false,
      ship: false,
      basic: false,
      graph: false
    };

    let domain = getDomain(server);
    console.log(domain);
    if (domain != null) {
      SafeFetch.get(WoWsAPI.PlayerInfo, getDomain(server), account_id).then(data => {
        // Check if account is hidden
        console.log(data);
        let hidden = Guard(data, 'meta.hidden', true);
        if (hidden || hidden != null) {
          // If hidden is not null, it is hidden
          this.setState({hidden: true});
        }

        // Get player data here
        let player = Guard(data, `data.${account_id}`, null);
        if (player == null) {
          // Invalid data
          this.setState({valid: false});
        } else {
          let battle = Guard(player, 'statistics.pvp.battles', 0);
          // Treat zero battle account as hidden
          if (battle == 0) this.setState({hidden: true});
          else this.setState({data: player});
        }
      });
    } else {
      // Invalid domain
      this.setState({valid: false});
    }
  }

  render() {
    const { error, container, buttons } = styles;
    const { home, friend } = this.props;
    const { name, id, data, valid, hidden } = this.state;

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
    } else if (hidden) {
      // Hidden account
      return (
        <RootView style={container}>
          <Text>{`${name} is Hidden`}</Text>
        </RootView>
      );
    } else {
      // Display player data
      return (
        <RootView style={container} noLeft={friend}>
          <SafeAreaView>
            <Text>{name}</Text>
            { this.renderBasic() }
            <View style={buttons}>
              { this.renderAchievement() }
              { this.renderShip() }
              { this.renderGraph() }
              { this.renderRank() }
            </View>
          </SafeAreaView>
        </RootView>
      );
    }

  };

  ///
  // I will do parallel data loading so each of them will have 
  // their own state to check if the button could be rendered
  ///

  renderBasic() {
    const { container, buttons } = styles;
    const { basic } = this.state;

    if (!basic) return <LoadingIndicator />
    return (
      <View>
      </View>
    )
  }

  renderAchievement() {
    const { container, buttons } = styles;
    const { achievement } = this.state;

    if (!achievement) return <LoadingIndicator />
    return (
      <Button>Achievement</Button>
    )
  }

  renderShip() {
    const { container, buttons } = styles;
    const { ship } = this.state;

    if (!ship) return <LoadingIndicator />
    return <Button>ship</Button>    
  }

  renderRank() {
    const { container, buttons } = styles;
    const { rank } = this.state;

    if (!rank) return <LoadingIndicator />
    return <Button>rank</Button>
  }

  renderGraph() {
    const { container, buttons } = styles;
    const { graph } = this.state;

    if (!graph) return <LoadingIndicator />
    return <Button>graph</Button>
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
  buttons: {
    flexDirection: 'row',
    justifyContent: 'space-around'
  }
});

export { Statistics };
