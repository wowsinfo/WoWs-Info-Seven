import React from 'react';
import { TabBarIOS, View } from 'react-native';
import { AchievementScreen, Basic, Graph, Rank, PlayerShip } from './';
import language from '../../constant/language';
import { Blue } from 'react-native-material-color';
import { getTextColour } from '../../constant/colour';
import { iconsMap } from '../../constant/icon';
import store from 'react-native-simple-store';
import { LocalData } from '../../constant/value';

export default class PlayerTab extends React.PureComponent {
  constructor(props) {
    super(props);
    this.state = {selectedTab: 'User'};
    props.navigator.setOnNavigatorEvent(this.onNavigatorEvent.bind(this));    
  }

  static navigatorStyle = { tabBarHidden: true }
  onNavigatorEvent(event) {
    if (event.type == 'NavBarButtonPress') {
      // Get object for player
      const { id, name, server } = this.props;
      let player = {id: id, name: name, server: server};
      if (event.id == 'star') {
        friend.push(player);
        this.props.navigator.setButtons({
          rightButtons:[{icon: iconsMap['star'], id: 'star-o'}]
        })
      } else if (event.id == 'star-o') {
        friend = friend.filter(function(obj) {return obj.id !== id})
        this.props.navigator.setButtons({
          rightButtons:[{icon: iconsMap['star-o'], id: 'star'}]
        })
      }
      store.save(LocalData.friend, friend);
    }
  }

  setTab(ID) {
    this.setState({selectedTab: ID});
  }

  render() {
    let color = theme[500];
    return (
      <TabBarIOS itemPositioning='center' tintColor={color} barTintColor={getTextColour(color)}>
        <TabBarIOS.Item icon={require('../../img/AchievementTab.png')} title={language.achievement_tab_title}
          selected={this.state.selectedTab === 'Acievement'}
          onPress={() => this.setTab('Acievement')}>
          <AchievementScreen {...this.props}/>
        </TabBarIOS.Item>
        <TabBarIOS.Item icon={require('../../img/Graph.png')} title={language.graph_tab_title}
          selected={this.state.selectedTab === 'Graph'}
          onPress={() => this.setTab('Graph')}>
          <Graph {...this.props}/>
        </TabBarIOS.Item>
        <TabBarIOS.Item icon={require('../../img/User.png')} title={language.basic_tab_title}
          selected={this.state.selectedTab === 'User'}
          onPress={() => this.setTab('User')}>
          <Basic {...this.props}/>
        </TabBarIOS.Item>
        <TabBarIOS.Item icon={require('../../img/Ship.png')} title={language.warship_tab_title}
          selected={this.state.selectedTab === 'Ship'}
          onPress={() => this.setTab('Ship')}>
          <PlayerShip {...this.props}/>
        </TabBarIOS.Item>
        <TabBarIOS.Item icon={require('../../img/Rank.png')} title={language.rank_tab_title}
          selected={this.state.selectedTab === 'Rank'}
          onPress={() => this.setTab('Rank')}>
          <Rank {...this.props}/>
        </TabBarIOS.Item>
      </TabBarIOS>
    )
  }
}