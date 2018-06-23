import React from 'react';
import { View, StyleSheet, Dimensions, Image } from 'react-native';
import { AchievementScreen, Basic, Graph, Rank, PlayerShip } from './';
import { TabViewAnimated, TabBar, SceneMap } from 'react-native-tab-view';
import { getTextColour } from '../../constant/colour';
import store from 'react-native-simple-store';
import { iconsMap } from '../../constant/icon';
import { LocalData } from '../../constant/value';
import { Divider } from 'react-native-elements';

// Faster loading
const initialLayout = {
  height: 0,
  width: Dimensions.get('window').width,
};

export default class PlayerTab extends React.PureComponent {
  constructor(props) {
    super(props);
    this.state = {
      index: 2, routes: [
        {key: 'achievement', icon: require('../../img/AchievementTab.png')},
        {key: 'graph', icon: require('../../img/Graph.png')},
        {key: 'basic', icon: require('../../img/User.png')},
        {key: 'ship', icon: require('../../img/Ship.png')},
        {key: 'rank', icon: require('../../img/Rank.png')},
      ]
    };
    props.navigator.setOnNavigatorEvent(this.onNavigatorEvent.bind(this));    
  }

  static navigatorStyle = {
    navBarNoBorder: true,
    topBarElevationShadowEnabled: false
  }

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
    'ship': () => <PlayerShip {...this.props}/>,
    'rank': () => <Rank {...this.props}/>,
  });

  render() {
    return (
      <TabViewAnimated style={tabViewStyle} navigationState={this.state}
        renderScene={this.renderScene} renderHeader={this.renderHeader}
        onIndexChange={this.handleIndexChange} initialLayout={initialLayout} />
    )
  }
}

const styles = StyleSheet.create({
  tabViewStyle: {
    flex: 1,
  },
  tabStyle: {
    backgroundColor: 'transparent',
    height: 44,
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