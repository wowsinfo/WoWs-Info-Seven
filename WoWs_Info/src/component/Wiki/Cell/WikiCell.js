import React from 'react';
import { Card } from 'react-native-elements';
import { View, TouchableWithoutFeedback, Alert } from 'react-native';
import { WikiCellStyles } from './StylesForAll';

class WikiCell extends React.PureComponent {
  componentWillMount() {
    this.name = this.props.data.name;
    this.icon = this.props.data.icon;
  }

  render() {
    return (
      <View style={viewStyle}>
        <TouchableWithoutFeedback style={touchableStyle} onPress={() => this.onWikiBtnPressed()}>
          <Card containerStyle={cardStyle} title={this.name}/>
        </TouchableWithoutFeedback>
      </View>
    )
  }

  onWikiBtnPressed() {
    Alert.alert('Yaho >_<');
  }
}

const { viewStyle, cardStyle, touchableStyle } = WikiCellStyles;

export {WikiCell};