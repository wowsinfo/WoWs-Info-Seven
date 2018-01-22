import React from 'react';
import { WoWsTouchable } from '../../../component';
import { Actions } from 'react-native-router-flux';
import { styles } from './SearchResultCellStyles';
import { View, Text, Image } from 'react-native';
import { FadeInView } from '../../../Animation';

class SearchResultCell extends React.PureComponent {
  render() {
    return (
      <FadeInView>
        <WoWsTouchable onPress={this.playerInfo}>
          { this.renderView() }
        </WoWsTouchable>
      </FadeInView>
    )
  }

  renderView() {
    const { viewStyle, textStyle, roleViewStyle, imageStyle } = styles;  
    const { name, id, role } = this.props.data;  
    if (this.props.role == true) {
      var image = require('../../../img/Member.png'); var isMember = true;
      switch (role) {
        case 'commander': 
          image = require('../../../img/Commander.png'); isMember = false; break;
        case 'executive_officer':  
          image = require('../../../img/ViceCommander.png'); isMember = false; break;
      }

      return (
        <View style={roleViewStyle}>
          { isMember ? <Image source={image} style={[imageStyle, {tintColor: global.themeColour}]}/> : <Image source={image} style={imageStyle}/> }
          <Text style={textStyle}>{name + '|' + id}</Text> 
        </View>
      )
    } else {
      return (
        <View style={viewStyle}>
          <Text style={textStyle}>{name + '|' + id}</Text> 
        </View>
      )
    }
  }

  playerInfo = () => {
    const { name, id, server } = this.props.data;
    Actions.PlayerScreen({title: id, playerName: name, id: id, server: server});
  }
}

export {SearchResultCell};