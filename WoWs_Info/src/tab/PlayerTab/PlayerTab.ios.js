import React from 'react';
import { TabBarIOS, View } from 'react-native';
import { BasicInfoScreen } from '../../screen';

class PlayerTab extends React.PureComponent {
  constructor(props) {
    super(props);
    this.state = {selectedTab: 'User'};
  }

  setTab(ID) {
    this.setState({selectedTab: ID});
  }

  render() {
    return (
      <TabBarIOS itemPositioning='center' tintColor={global.themeColour} translucent>
        <TabBarIOS.Item icon={require('../../img/User.png')} iconSize={32}
          selected={this.state.selectedTab === 'Acievement'}
          onPress={() => this.setTab('Acievement')}>
          <View />
        </TabBarIOS.Item>
        <TabBarIOS.Item icon={require('../../img/Graph.png')} iconSize={32}
          iconImageStyle={{width: 23, height: 23, resizeMode:'contain'}}
          selected={this.state.selectedTab === 'Graph'}
          onPress={() => this.setTab('Graph')}>
          <View />
        </TabBarIOS.Item>
        <TabBarIOS.Item icon={require('../../img/User.png')} iconSize={32}
          selected={this.state.selectedTab === 'User'}
          onPress={() => this.setTab('User')}>
          <BasicInfoScreen />
        </TabBarIOS.Item>
        <TabBarIOS.Item icon={require('../../img/Ship.png')} iconSize={32}
          selected={this.state.selectedTab === 'Ship'}
          onPress={() => this.setTab('Ship')}>
          <View />
        </TabBarIOS.Item>
        <TabBarIOS.Item icon={require('../../img/Rank.png')} iconSize={32}
          selected={this.state.selectedTab === 'Rank'}
          onPress={() => this.setTab('Rank')}>
          <View />
        </TabBarIOS.Item>
      </TabBarIOS>
    )
  }
}

export {PlayerTab};