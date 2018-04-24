import React from 'react';
import { View, Image, Text, StyleSheet } from 'react-native';
import { WoWsTouchable } from '../../component';

class NewsCell extends React.PureComponent {
  render() {
    const { image, title, time } = this.props.data;
    const { mainViewStyle, imageViewStyle, textViewStyle, imageStyle, titleStyle, timeStyle } = styles;    
    return (
      <View style={{flex: 1}}>
        <WoWsTouchable onPress={this.visitWebsite}>
          <View style={mainViewStyle}>
            <View style={imageViewStyle}>
              <Image source={{uri: image}} style={imageStyle} resizeMode='contain'/>
            </View>
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
    const { link, time } = this.props.data;
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
    width: 100,
    margin: 0,
    padding: 4,
    justifyContent: 'center',
  },
  textViewStyle: {
    flex: 1,
    margin: 0,
    padding: 8,
    justifyContent: 'space-around',
  },
  imageStyle: {
    width: 100,
    height: 100 / 1.52,
    margin: 0,
  },
  titleStyle: {
    fontSize: 16,
  },
  timeStyle: {
    fontSize: 12,
    textAlign: 'right',
  }
})

export { NewsCell };