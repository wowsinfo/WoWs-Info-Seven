import React, { Component } from 'react';
import { ProgressViewIOS, View, Text, StyleSheet } from 'react-native';

class WoWsProgress extends Component {
  render() {
    const { value, color , title } = this.props;
    const { viewStyle, textStyle, titleStyle, progressStyle } = styles;
    if (value == 0) return null;
    else return (
      <View>
        <Text style={titleStyle}>{title}</Text>      
        <View style={viewStyle}>
          { android ? <Text style={{flex: value / 100, backgroundColor: color, height: 3}}/>
            : <ProgressViewIOS style={progressStyle} progressTintColor={color} progress={value / 100}/> }
          <Text style={textStyle}>{value}</Text>
        </View>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flexDirection: 'row', flex: 1,
    alignItems: 'center', marginTop: 8
  },
  textStyle: {
    padding: 4, fontWeight: 'bold', width: 46, textAlign: 'center'
  },
  titleStyle: {
    paddingLeft: 8, fontWeight: '300'
  },
  progressStyle: {
    flex: 1, marginLeft: 4
  }
})

export { WoWsProgress };