import React, { Component } from 'react';
import { StyleSheet, View, SafeAreaView, Alert, Dimensions } from 'react-native';
import { IconButton, Text, Colors, Surface, DarkTheme, DefaultTheme, withTheme } from 'react-native-paper';
import { TabView, TabBar, SceneMap } from 'react-native-tab-view';
import { FloatingButton, SafeView, WoWsInfo, LoadingModal } from '../../component';
import { Actions } from 'react-native-router-flux';
import { GREY } from 'react-native-material-color';
import { LOCAL, getFirstLaunch, getCurrServer, setFirstLaunch } from '../../value/data';
import { Friend, RS, Statistics } from '../';
import { SafeAction, DataLoader, Downloader } from '../../core';
import { TintColour } from '../../value/colour';
import lang from '../../value/lang';
import { Loading } from '../common/Loading';

class Home extends Component {
  constructor(props) {
    super(props);

    let first = getFirstLaunch();
    this.state = {
      index: 0,
      // there are three tabs (statistics, friends and rs)
      routes: [
        { key: 'stat', title: 'Statistics' },
        { key: 'friend', title: 'Friends' },
        { key: 'rs', title: 'RS Beta' },
      ],
      loading: first,
      updating: true,
    };

    if (first) {
      // Update data here if it is not first launch
      let dn = new Downloader(getCurrServer());
      dn.updateAll(true).then(success => {
        // Make sure it finishes downloading
        if (success) {
          this.setState({loading: false});
          setFirstLaunch(false);
        } else {
          // Reset to a special page
          // For now, just an error message
          Alert.alert(lang.error_title, lang.error_download_issue);
        }
      });
    }
  }

  render() {
    const { loading, updating } = this.state;
    const { container } = styles;
    if (loading) return <Loading />;

    const appTheme = TintColour();
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
            stat: () => <Statistics info={DATA[LOCAL.userInfo]} home/>,
            friend: () => <Friend />,
            rs: () => <RS />
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
  }
});

export { Home };
