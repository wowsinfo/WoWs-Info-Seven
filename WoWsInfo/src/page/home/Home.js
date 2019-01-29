import React, { Component } from 'react';
import { StyleSheet, View, SafeAreaView, ScrollView, Dimensions } from 'react-native';
import { IconButton, Text, Colors, Surface, DarkTheme, DefaultTheme, withTheme } from 'react-native-paper';
import { TabView, TabBar, SceneMap } from 'react-native-tab-view';
import { FloatingButton, SafeView, WoWsInfo, LoadingModal } from '../../component';
import { Actions } from 'react-native-router-flux';
import { GREY } from 'react-native-material-color';
import { LOCAL, getFirstLaunch, getCurrServer } from '../../value/data';
import { Friend, RS, Statistics } from '../';
import { SafeAction, DataLoader, Downloader } from '../../core';
import { TintColour } from '../../value/colour';

class Home extends Component {
  constructor(props) {
    super(props);

    this.state = {
      index: 0,
      // there are three tabs (statistics, friends and rs)
      routes: [
        { key: 'stat', title: 'Statistics' },
        { key: 'friend', title: 'Friends' },
        { key: 'rs', title: 'RS Beta' },
      ],
      loading: true,
      updating: true,
      dark: false
    };

  }

  render() {
    const { loading, updating } = this.state;
    const { container, playerLabel, header } = styles;
    if (loading) return null;

    const appTheme = DATA[LOCAL.theme];
    return (
      <WoWsInfo style={container} home about>
        <TabView renderTabBar={props =>
            <TabBar pressOpacity={0.5} {...props} renderLabel={r => {
              return <Text style={{fontWeight: '300', fontSize: 17, color: appTheme[500]}}>{r.route.title}</Text>
            }} style={{backgroundColor: null, height: 48, justifyContent: 'center'}}
              indicatorStyle={{backgroundColor: appTheme[700]}}
            />
          } navigationState={this.state}
          renderScene={SceneMap({
            stat: () => <Statistics info={DATA[LOCAL.userInfo]}/>,
            friend: Friend,
            rs: RS
          })} onIndexChange={index => this.setState({index})}
          initialLayout={Dimensions.get('window')}
        />
      </WoWsInfo>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    width: '100%', 
    flexDirection: 'row', 
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 8
  },
  playerLabel: {
    fontSize: 32,
    padding: 8,
    width: '80%',
    fontWeight: 'bold'
  }
});

export default withTheme(Home);
