import React from 'react';
import { TabBarIOS } from 'react-native';
import { WikiScreen, NewsScreen, SettingsScreen } from '../../screen';
import { Actions } from 'react-native-router-flux';
import strings from '../../localization';

class MainTab extends React.PureComponent {
  constructor(props) {
    super(props);
    this.state = {selectedTab: 'News'};
  }

  componentWillMount() {
    let isPro = global.isPro;
    let hasAds = global.hasAds;
    let userInfo = global.userInfo;
    console.log(isPro, hasAds, userInfo);
    if (isPro && userInfo.id != '' && global.showMainAccount){
      Actions.PlayerScreen({title: userInfo.id, playerName: userInfo.name, id: userInfo.id, server: userInfo.server});
      global.showMainAccount = false;
    }
    if (hasAds) {
      // Show ads here in the future
    }
  }

  setTab(ID) {
    this.setState({selectedTab: ID});
  }

  render() {
    return (
      <TabBarIOS tintColor={global.themeColour} translucent>
        <TabBarIOS.Item title={strings.wiki}
          icon={require('../../img/Wiki.png')}
          selected={this.state.selectedTab === 'Wiki'}
          onPress={() => this.setTab('Wiki')}>
          <WikiScreen />
        </TabBarIOS.Item>
        <TabBarIOS.Item title={strings.news}
          icon={require('../../img/News.png')}
          selected={this.state.selectedTab === 'News'}
          onPress={() => this.setTab('News')}>
          <NewsScreen />            
        </TabBarIOS.Item>
        <TabBarIOS.Item title={strings.settings}
          icon={require('../../img/Settings.png')}
          selected={this.state.selectedTab === 'Settings'}
          onPress={() => this.setTab('Settings')}>
          <SettingsScreen reset={this.props.reset}/>
        </TabBarIOS.Item>
      </TabBarIOS>
    )
  }
}

export {MainTab};