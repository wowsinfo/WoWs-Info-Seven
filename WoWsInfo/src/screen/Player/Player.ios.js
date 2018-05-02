import React from 'react';
import { TabBarIOS, View } from 'react-native';
import { AchievementScreen, Basic, Graph, Rank, Ship } from './';
import language from '../../constant/language';
import { Blue } from 'react-native-material-color';
import { getTextColour } from '../../constant/colour';

export default class PlayerTab extends React.PureComponent {
  constructor(props) {
    super(props);
    this.state = {selectedTab: 'User'};
  }

  static navigatorStyle = { tabBarHidden: true }

  setTab(ID) {
    this.setState({selectedTab: ID});
  }

  render() {
    let color = theme[500];
    let barStyle = getTextColour(color) == '#000000' ? 'black' : 'default';
    return (
      <TabBarIOS itemPositioning='center' tintColor={color} barStyle={barStyle} translucent>
        <TabBarIOS.Item icon={require('../../img/AchievementTab.png')} title={language.achievement_tab_title}
          selected={this.state.selectedTab === 'Acievement'}
          onPress={() => this.setTab('Acievement')}>
          <AchievementScreen {...this.props}/>
        </TabBarIOS.Item>
        <TabBarIOS.Item icon={require('../../img/Graph.png')} title={language.graph_tab_title}
          selected={this.state.selectedTab === 'Graph'}
          onPress={() => this.setTab('Graph')}>
          <Graph />
        </TabBarIOS.Item>
        <TabBarIOS.Item icon={require('../../img/User.png')} title={language.basic_tab_title}
          selected={this.state.selectedTab === 'User'}
          onPress={() => this.setTab('User')}>
          <Basic {...this.props}/>
        </TabBarIOS.Item>
        <TabBarIOS.Item icon={require('../../img/Ship.png')} title={language.warship_tab_title}
          selected={this.state.selectedTab === 'Ship'}
          onPress={() => this.setTab('Ship')}>
          <Ship {...this.props}/>
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