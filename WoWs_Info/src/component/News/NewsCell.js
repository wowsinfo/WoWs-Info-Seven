import React from 'react';
import { View, Image, Text } from 'react-native';
import { WoWsTouchable } from '../../component';
import { styles } from './NewsCellStyles';
import { InAppBrowser } from '../../screen';
import { Actions } from 'react-native-router-flux';

class NewsCell extends React.PureComponent {
  render() {
    const { image, title, time } = this.props.data;
    return (
      <View>
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
    Actions.InAppBrowser({link: this.link, title: this.time});
  }
}

const { mainViewStyle, imageViewStyle, textViewStyle, imageStyle, titleStyle, timeStyle } = styles;

export {NewsCell};