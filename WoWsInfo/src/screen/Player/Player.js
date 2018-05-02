import React from 'react';
import { View, StyleSheet, Dimensions, Image } from 'react-native';
import { AchievementScreen, Basic, Graph, Rank, Ship } from './';
import { TabViewAnimated, TabBar, SceneMap } from 'react-native-tab-view';
import { getTextColour } from '../../constant/colour';

// Faster loading
const initialLayout = {
  height: 0,
  width: Dimensions.get('window').width,
};

export default class PlayerTab extends React.PureComponent {
  state = {
    index: 2,
    routes: [
      {key: 'achievement', icon: require('../../img/AchievementTab.png')},
      {key: 'graph', icon: require('../../img/Graph.png')},
      {key: 'basic', icon: require('../../img/User.png')},
      {key: 'ship', icon: require('../../img/Ship.png')},
      {key: 'rank', icon: require('../../img/Rank.png')},
    ]
  };

  static navigatorStyle = {
    navBarNoBorder: true,
    topBarElevationShadowEnabled: false
  }

  // Setup stuff for tab view
  handleIndexChange = index => this.setState({index});
  renderIcon = ({route}) => (
    <Image source={route.icon} style={[imageStyle, {tintColor: getTextColour(theme[500])}]} resizeMode='contain'/>
  );
  renderHeader = props => {
    return (
      <TabBar {...props} indicatorStyle={{backgroundColor: getTextColour(theme[500])}} renderIcon={this.renderIcon}
        style={{backgroundColor: theme[500]}} tabStyle={tabStyle}/>
    )
  }
  renderScene = SceneMap({
    'achievement': () => <AchievementScreen {...this.props}/>,
    'graph': () => <Graph {...this.props}/>,
    'basic': () => <Basic {...this.props}/>,
    'ship': () => <Ship {...this.props}/>,
    'rank': () => <Rank {...this.props}/>,
  });

  render() {
    return (
      <TabViewAnimated style={tabViewStyle}
        navigationState={this.state}
        renderScene={this.renderScene} renderHeader={this.renderHeader}
        onIndexChange={this.handleIndexChange}
        initialLayout={initialLayout} />
    )
  }
}

const styles = StyleSheet.create({
  tabViewStyle: {
    flex: 1,
  },
  tabStyle: {
    backgroundColor: 'transparent',
    height: 40,
    padding: 0,
    margin: 0,
  },
  imageStyle: {
    height: 26,
    width: 26,
    tintColor: 'white',
  }
})
const { tabViewStyle, tabStyle, imageStyle } = styles;