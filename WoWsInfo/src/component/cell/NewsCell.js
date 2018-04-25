import React, { Component } from 'react';
import { View, Image, Text, StyleSheet, Linking } from 'react-native';
import { WoWsTouchable } from '../../component';
import { scale } from 'react-native-size-matters';
import { GREY } from 'react-native-material-color';

class NewsCell extends Component {
  render() {
    const { image, title, time } = this.props.data;
    const { mainViewStyle, imageViewStyle, textViewStyle, imageStyle, titleStyle, timeStyle } = styles;    
    return (
      <View style={{flex: 1}}>
        <WoWsTouchable onPress={this.visitWebsite}>
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
      </View>
    );
  }

  visitWebsite = () => {
    const { link } = this.props.data;
    Linking.openURL(link);
  }
}

const styles = StyleSheet.create({
  mainViewStyle: {
    flex: 1,
    flexDirection: 'row',
    margin: 0,
    padding: 0,
  },
  imageViewStyle: {
    width: scale(120),
    margin: 0,
    padding: 4, elevation: 2,
    justifyContent: 'center',
  },
  textViewStyle: {
    flex: 1,
    margin: 0,
    padding: 8,
    justifyContent: 'space-around',
  },
  imageStyle: {
    width: scale(120),
    height: scale(120 / 1.52),
    margin: 0, borderRadius: 4
  },
  titleStyle: {
    fontSize: scale(14), fontWeight: '300',
    color: GREY[900]
  },
  timeStyle: {
    fontSize: scale(10), fontWeight: 'bold',
    textAlign: 'right', color: GREY[500]
  }
})

export { NewsCell };