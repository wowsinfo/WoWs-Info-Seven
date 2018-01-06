import React from 'react';
import { View, StyleSheet, Dimensions, Settings } from 'react-native';
import { WikiScreen, NewsScreen, SettingsScreen } from '../../screen';
import { TabViewAnimated, TabBar, SceneMap } from 'react-native-tab-view';
import { Actions } from 'react-native-router-flux';
import strings from '../../localization';

// Faster loading
const initialLayout = {
  height: 0,
  width: Dimensions.get('window').width,
};

class MainTab extends React.PureComponent {
  state = {
    index: 1,
    routes: [
      {key: 'wiki', title: strings.wiki},
      {key: 'news', title: strings.news},
      {key: 'settings', title: strings.settings},
    ],
  };

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

  renderSettings = () => (
    <SettingsScreen reset={this.props.reset}/>
  )

  // Setup stuff for tab view
  handleIndexChange = index => this.setState({index});
  renderHeader = props => {
    return (
      <TabBar {...props} indicatorStyle={indicatorStyle}
        style={{backgroundColor: global.themeColour}} tabStyle={tabStyle}/>
    )
  }
  renderScene = SceneMap({
    'wiki': WikiScreen,
    'news': NewsScreen,
    'settings': this.renderSettings,
  });

  render() {
    return (
      <TabViewAnimated
        style={tabViewStyle}
        navigationState={this.state}
        renderScene={this.renderScene}
        renderHeader={this.renderHeader}
        onIndexChange={this.handleIndexChange}
        initialLayout={initialLayout} />
    )
  }
}

const styles = StyleSheet.create({
  tabViewStyle: {
    flex: 1,
  },
  indicatorStyle: {
    backgroundColor: 'white',
  },
  tabStyle: {
    backgroundColor: 'transparent',
    height: 50,
    padding: 0,
    margin: 0,
  },
})
const { tabViewStyle, indicatorStyle, tabStyle } = styles;

export {MainTab};