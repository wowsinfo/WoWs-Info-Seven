import React, { Component } from 'react';
import { View, Text, Image, StyleSheet } from 'react-native';
import { Blue } from 'react-native-material-color';

class RecordCell extends Component {
  render() {
    const { title, image, name, number } = this.props.info;
    const { mainViewStyle, titleStyle, subViewStyle, imageStyle, numberStyle, nameStyle, imageViewStyle, numberViewStyle } = styles;
    let color = theme[500] == '#ffffff' ? Blue : theme[500];    
    return (
      <View style={[mainViewStyle, {borderColor: color}]}>
        <Text style={titleStyle}>{title}</Text>
        <View style={subViewStyle}>
          <View style={imageViewStyle}>
            <Image style={imageStyle} source={{uri: image}}/>
            <Text style={nameStyle}>{name}</Text>          
          </View>
          <Text style={numberStyle}>{number}</Text>            
        </View>           
      </View>
    )
  }
}

const styles = StyleSheet.create({
  mainViewStyle: {
    flex: 1,
    margin: 6,
    paddingTop: 2, paddingBottom: 2,   
    borderWidth: 1,
    borderRadius: 8
  },
  titleStyle: {
    textAlign: 'center',
    fontSize: 28, fontWeight: '300',
  },
  subViewStyle: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'center',
  },
  imageViewStyle: {
    alignItems: 'center',
  },
  imageStyle: {
    width: 150,
    height: 90,
  },
  nameStyle: {
    textAlign: 'center',
  },
  numberStyle: {
    fontSize: 34,
    textAlign: 'center',
    fontWeight: '200',
    width: 160,
    height: 50,
  },
})

export { RecordCell };