import React from 'react';
import { View, Image, Text } from 'react-native';
import { WoWsTouchable } from '../../../component';
import { wikiIndex } from '../../../constant/value';
import { styles } from './WikiCellStyles';
import { Actions } from 'react-native-router-flux';

class WikiCell extends React.PureComponent {
  render() {
    const { name } = this.props.data;
    return (
      <View style={mainViewStyle}>
        <WoWsTouchable onPress={() => this.onWikiBtnPressed()}>
          <View style={viewStyle}>
            {this.renderImage()}
            <Text style={textStyle}>{name}</Text>     
          </View>        
        </WoWsTouchable>
      </View>
    )
  }

  renderImage() {
    const { index, icon } = this.props.data;
      // Warship needs a background colour
    if (index == 2) 
      return <Image style={[{backgroundColor: global.themeColour, overlayColor: 'white'}, imageStyle]} source={icon}/>
    else return <Image style={imageStyle} source={icon}/> 
  }

  onWikiBtnPressed() {
    const { index } = this.props.data;  
    // Fix double 
    let action = global.wikiAction; action.push(index);
    let length = action.length;
    console.log(action);
    if (length > 1 && (action[length - 1] == action[length - 2])) {
      global.wikiAction = []; return;
    }
    switch (index) {
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

const { viewStyle, imageStyle, textStyle, mainViewStyle } = styles;

export {WikiCell};