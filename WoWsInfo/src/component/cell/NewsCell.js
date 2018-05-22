import React, { Component } from 'react';
import { View, Image, Text, StyleSheet, Linking } from 'react-native';
import { WoWsTouchable } from '../../component';
import { scale } from 'react-native-size-matters';
import ElevatedView from 'react-native-elevated-view';
import { GREY } from 'react-native-material-color';

class NewsCell extends Component {
  render() {
    const { image, title, time, link } = this.props.data;
    const { mainViewStyle, imageViewStyle, textViewStyle, imageStyle, titleStyle, timeStyle } = styles;    
    return (
      <ElevatedView elevation={1} style={{margin: 8}}>
        <WoWsTouchable onPress={() => Linking.openURL(link)}>
          <View style={mainViewStyle}>
            { data_saver ? null : (
              <View style={imageViewStyle}>
                <Image source={{uri: image}} style={imageStyle} resizeMode='contain'/>
              </View>
              )}
            <View style={textViewStyle}>
              <Text style={titleStyle}>{title}</Text>
              <Text style={timeStyle}>{time}</Text>
            </View>
          </View>
        </WoWsTouchable>
      </ElevatedView>
    );
  }
}

const styles = StyleSheet.create({
  mainViewStyle: {
    flex: 1, flexDirection: 'row',
  },
  imageViewStyle: {
    width: 120,
    justifyContent: 'center',
  },
  textViewStyle: {
    flex: 1,
    padding: 8,
    justifyContent: 'space-around',
  },
  imageStyle: {
    width: 120,
    height: 120 / 1.52
  },
  titleStyle: {
    fontSize: 14, fontWeight: '300',
    color: GREY[900]
  },
  timeStyle: {
    fontSize: 10, fontWeight: 'bold',
    textAlign: 'right', color: GREY[500]
  }
})

export { NewsCell };