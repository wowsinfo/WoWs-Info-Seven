import React from 'react';
import { Text, View } from 'react-native';
import { WoWsTouchable } from '../../../component';
import { Actions } from 'react-native-router-flux';
import { styles } from './MapCellStyles';

class MapCell extends React.PureComponent {
  componentWillMount() {
    this.data = this.props.data;    
    this.name = this.data.name;
  }

  render() {
    return (
      <View>
        <WoWsTouchable onPress={this.showMapDetail}>
          <View style={viewStyle}>
            <Text style={[textStyle, {color: global.themeColour}]}>{this.name}</Text>
          </View>
        </WoWsTouchable>
      </View>
    )
  }

  showMapDetail = () => {
    Actions.MapDetailScreen({title: this.name, data: this.data});
  }
}

const { textStyle, viewStyle, touchableStyle } = styles;

export {MapCell};