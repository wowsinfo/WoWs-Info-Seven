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
    // console.log(this.icon);
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
    if (this.index == 1 || this.index > 5) {
      return <Image style={imageStyle} source={{uri: this.icon}}/>  
    } else {
      // Warship needs a background colour
      if (this.index == 2) 
        return <Image style={[{backgroundColor: global.themeColour, overlayColor: 'white'}, imageStyle]} source={this.icon}/>
      else return <Image style={imageStyle} source={this.icon}/> 
    }
  }

  onWikiBtnPressed() {
    // console.log(this.index);
    switch (this.index) {
      case wikiIndex.Achievement: Actions.AchievementScreen(); break;
      case wikiIndex.Flag_Camouflage: Actions.BasicScreen({info: global.consumableJson, upgrade: false}); break;    
      case wikiIndex.Warship: Actions.ShipScreen(); break;    
      case wikiIndex.Commander: Actions.BasicScreen({info: global.commanderSkillJson}); break;      
      case wikiIndex.Upgrade: Actions.BasicScreen({info: global.consumableJson, upgrade: true}); break;      
      case wikiIndex.Map: Actions.MapScreen(); break;
      case wikiIndex.Collection: Actions.BasicScreen({info: global.collectionJson}); break;
    }
  }
}

const { viewStyle, imageStyle, textStyle } = styles;

export {WikiCell};