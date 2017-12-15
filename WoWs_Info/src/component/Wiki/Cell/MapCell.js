import React from 'react';
import { Text, View, TouchableNativeFeedback, TouchableWithoutFeedback, Platform } from 'react-native';
import { Actions } from 'react-native-router-flux';
import { styles } from './MapCellStyles';

const Touchable = (Platform.OS == 'android') ? TouchableNativeFeedback : TouchableWithoutFeedback;

class MapCell extends React.PureComponent {
  componentWillMount() {
    this.data = this.props.data;    
    this.name = this.data.name;
  }

  render() {
    return (
      <View>
        <Touchable onPress={this.showMapDetail}>
          <View style={viewStyle}>
            <Text style={[textStyle, {color: global.themeColor}]}>{this.name}</Text>
          </View>
        </Touchable>
      </View>
    )
  }

  showMapDetail = () => {
    Actions.MapDetailScreen({title: this.name, data: this.data});
  }
}

const { textStyle, viewStyle, touchableStyle } = styles;

export {MapCell};