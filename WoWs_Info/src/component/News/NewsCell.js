import React from 'react';
import { View, Image, Text } from 'react-native';
import { WoWsTouchable } from '../../component';
import { styles } from './NewsCellStyles';
import { InAppBrowser } from '../../screen';
import { Actions } from 'react-native-router-flux';

class NewsCell extends React.PureComponent {
  componentWillMount() {
    this.image = this.props.data.image;
    this.link = this.props.data.link;
    this.title = this.props.data.title;;
    this.time = this.props.data.time;
  }

  render() {
    return (
      <View>
        <WoWsTouchable onPress={this.visitWebsite}>
          <View style={mainViewStyle}>
            <View style={imageViewStyle}>
              <Image source={{uri: this.image}} style={imageStyle} resizeMode='contain'/>
            </View>
            <View style={textViewStyle}>
              <Text style={titleStyle}>{this.title}</Text>
              <Text style={timeStyle}>{this.time}</Text>
            </View>
          </View>
        </WoWsTouchable>
      </View>
    );
  }

  visitWebsite = () => {
    Actions.InAppBrowser({link: this.link, title: this.time});
  }
}

const { mainViewStyle, imageViewStyle, textViewStyle, imageStyle, titleStyle, timeStyle } = styles;

export {NewsCell};