import React, { Component } from 'react';
import { StyleSheet, View, SafeAreaView, ScrollView, Dimensions } from 'react-native';
import { IconButton, Text, Colors, Surface } from 'react-native-paper';
import { TabView, TabBar, SceneMap } from 'react-native-tab-view';
import { FloatingButton } from '../../component';
import { Actions } from 'react-native-router-flux';
import { GREY } from 'react-native-material-color';
import { LOCAL } from '../../value/data';
import { Friend, RS, Statistics } from '../';

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
    }
  }

  render() {
    const { container, playerLabel, header } = styles;
    const appTheme = DATA[LOCAL.theme];
    return (
      <Surface theme={{colors: {background: GREY[800]}}} style={container}>
        <SafeAreaView style={{height: '100%'}}>
          <Surface style={header}>
            <Text numberOfLines={1} style={playerLabel}>WoWs Info</Text>
            <IconButton icon='settings' size={24} color={Colors.grey500}
              onPress={() => Actions.Settings()}/>
          </Surface>
          <TabView renderTabBar={props =>
              <TabBar {...props} renderLabel={r => {
                return <Text style={{fontWeight: '500', fontSize: 17, color: appTheme[700]}}>{r.route.title}</Text>
              }} style={{ backgroundColor: 'transparent' }}
                indicatorStyle={{ backgroundColor: 'transparent'}}
              />
            } navigationState={this.state}
            renderScene={SceneMap({
              stat: () => <Statistics info={DATA[LOCAL.userInfo]}/>,
              friend: Friend,
              rs: RS
            })} onIndexChange={index => this.setState({index})}
            initialLayout={Dimensions.get('window')}
          />
          <FloatingButton />
        </SafeAreaView>
      </Surface>
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

export { Home };
