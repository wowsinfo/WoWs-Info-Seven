import React from 'react';
import { View, StyleSheet, Dimensions, Settings, Image } from 'react-native';
import { BasicInfoScreen, ShipInfoScreen, RankInfoScreen, ShowroomScreen } from '../../screen';
import { TabViewAnimated, TabBar, SceneMap } from 'react-native-tab-view';
import strings from '../../localization';

// Faster loading
const initialLayout = {
  height: 0,
  width: Dimensions.get('window').width,
};

const placeholder = () => <View />;

class PlayerTab extends React.PureComponent {
  state = {
    index: 0,
    routes: [
      {key: 'basic', icon: require('../../img/User.png')},
      {key: 'ship', icon: require('../../img/Ship.png')},
      {key: 'achievement', icon: require('../../img/AchievementTab.png')},      
      {key: 'rank', icon: require('../../img/Rank.png')},
    ],
  };

  // Setup stuff for tab view
  handleIndexChange = index => this.setState({index});
  renderIcon = ({route}) => (
    <Image source={route.icon} style={imageStyle} resizeMode='contain'/>
  );
  renderHeader = props => {
    return (
      <TabBar {...props} indicatorStyle={indicatorStyle} renderIcon={this.renderIcon}
        style={{backgroundColor: global.themeColour}} tabStyle={tabStyle}/>
    )
  }
  renderScene = SceneMap({
    'basic': () => <BasicInfoScreen {...this.props}/>,
    'ship': () => <ShipInfoScreen {...this.props}/>,
    'achievement': () => <ShowroomScreen {...this.props}/>,    
    'rank': () => <RankInfoScreen {...this.props}/>,
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
const { tabViewStyle, indicatorStyle, tabStyle, imageStyle } = styles;

export {PlayerTab};