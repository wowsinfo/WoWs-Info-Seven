import React, { Component } from 'react';
import { View, Image, Text, StyleSheet, Linking } from 'react-native';
import { WoWsBounce, WoWsTouchable } from '../../component';
import ElevatedView from 'react-native-elevated-view';
import { GREY } from 'react-native-material-color';

class NewsCell extends Component {
  render() {
    const { image, title, time, link } = this.props.data;
    const { mainViewStyle, imageViewStyle, textViewStyle, imageStyle, titleStyle, timeStyle } = styles;    
    const Touchable = android ? WoWsTouchable : WoWsBounce;
    return (
      <ElevatedView elevation={2} style={{margin: 6}}>
        <Touchable onPress={() => Linking.openURL(link)}>
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
        </Touchable>
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
    width: 124,
    height: 124 / 1.52
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