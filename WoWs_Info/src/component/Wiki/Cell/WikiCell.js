import React from 'react';
import { View, Image, Text } from 'react-native';
import { WoWsTouchable } from '../../../component';
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
      <View>
        <WoWsTouchable onPress={() => this.onWikiBtnPressed()} >
          <View style={viewStyle}>
            {this.renderImage()}
            <Text style={textStyle}>{this.name}</Text>     
          </View>        
        </WoWsTouchable>
      </View>
    )
  }

  renderImage() {
    // Warship needs a background colour
    if (this.index == 2) return <Image style={[imageStyle, {backgroundColor: global.themeColour}]} source={{uri: this.icon}}/>
    else return <Image style={imageStyle} source={{uri: this.icon}}/> 
  }

  onWikiBtnPressed() {
    // console.log(this.index);
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