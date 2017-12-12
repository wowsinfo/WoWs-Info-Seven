import React from 'react';
import { View, Image, Text, TouchableOpacity, Alert } from 'react-native';
import { wikiIndex } from '../../../constant/value';
import { styles } from './WikiCellStyles';
import { Actions } from 'react-native-router-flux';

class WikiCell extends React.PureComponent {
  componentWillMount() {
    this.name = this.props.data.name;
    this.icon = this.props.data.icon;
    this.index = this.props.data.index;
  }

  render() {
    return (
      <View style={viewStyle}>
        <TouchableOpacity onPress={() => this.onWikiBtnPressed()} >
          <Image style={imageStyle} source={{uri: 'https://placeimg.com/128/128/any'}}/>          
        </TouchableOpacity>
        <Text style={textStyle}>{this.name}</Text>
      </View>
    )
  }

  onWikiBtnPressed() {
    switch (this.index) {
      case wikiIndex.Achievement:
        Actions.AchievementScreen(); break;
      case wikiIndex.Flag_Camouflage:
        Actions.ConsumableScreen({index: wikiIndex.Flag_Camouflage}); break;    
      case wikiIndex.Warship:
        Actions.ShipScreen(); break;    
      case wikiIndex.Commander:
        Actions.CommanderScreen(); break;      
      case wikiIndex.Upgrade:
        Actions.ConsumableScreen({index: wikiIndex.Upgrade}); break;      
      case wikiIndex.Map:
        Actions.MapScreen(); break;
      default: return;
    }
  }
}

const { viewStyle, imageStyle, textStyle } = styles;

export {WikiCell};