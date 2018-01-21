import React, { Component } from 'react';
import { View } from 'react-native';
import { styles } from './SearchSegmentStyle';
import SegmentedControlTab from 'react-native-segmented-control-tab';
import strings from '../../localization';

class SearchSegment extends Component {
  render() {
    const { containerStyle, activeStyle, viewStyle, textStyle } = styles;
    return (
      <View style={viewStyle}>
        <SegmentedControlTab tabsContainerStyle={containerStyle} tabStyle={{backgroundColor: global.themeColour, borderColor: 'white'}} activeTabStyle={activeStyle} 
          tabTextStyle={textStyle} activeTabTextStyle={{color: global.themeColour}} values={[strings.search_player, strings.search_clan]}/>
      </View>
    )
  }
}

export {SearchSegment};