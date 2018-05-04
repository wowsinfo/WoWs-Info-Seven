import React, { Component } from 'react';
import { View, Text, Dimensions, StyleSheet } from 'react-native';
import { TabViewAnimated, TabBar, SceneMap } from 'react-native-tab-view';
import language from '../../constant/language';
import Website from './Website';
import Tool from './Tool';
import { getTextColour, navStyle, statusBarColour } from '../../constant/colour';

const initialLayout = {
  height: 0,
  width: Dimensions.get('window').width
};

export default class More extends Component {
  constructor(props) {
    super(props);
    console.log(this.props);
    this.props.navigator.setOnNavigatorEvent(this.onNavigatorEvent.bind(this));  
    this.state = {
      index: 0,
      routes: [{key: 'website', title: language.more_website_title}, {key: 'tool', title: language.more_tool_title}]
    }  
  }

  onNavigatorEvent(event) {
    if (event.type == 'NavBarButtonPress') {
      if (event.id == 'done') {
        this.props.navigator.dismissModal();
      }
    }
  }

  static navigatorStyle = {
    navBarNoBorder: true,
    topBarElevationShadowEnabled: false
  }

  handleIndexChange = index => this.setState({index});
  renderHeader = props => <TabBar tabStyle={tabStyle} indicatorStyle={{backgroundColor: getTextColour(theme[500])}} 
    labelStyle={{color: getTextColour(theme[500])}} {...props} style={{backgroundColor: theme[500]}}/>;
  renderScene = SceneMap({
    website: Website,
    tool: Tool
  });

  render() {
    return (
      <TabViewAnimated navigationState={this.state} renderScene={this.renderScene}
        renderHeader={this.renderHeader} onIndexChange={this.handleIndexChange}
        initialLayout={initialLayout}
      />
    )
  }
}

const styles = StyleSheet.create({
  tabStyle: {
    height: 40, backgroundColor: 'transparent',
    margin: 0, padding: 0
  }
})
const { tabStyle } = styles;
