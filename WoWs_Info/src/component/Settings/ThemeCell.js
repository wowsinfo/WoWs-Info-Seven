import React from 'react';
import { View, Text } from 'react-native';
import store from 'react-native-simple-store';
import { localDataName } from '../../constant/value';
import { WoWsTouchable } from '../../component';
import { Actions } from 'react-native-router-flux';
import { styles } from './ThemeCellStyles';

class ThemeCell extends React.PureComponent {
  componentWillMount() {
    this.colour = this.props.colour;
  }

  render() {
    return (
      <View>
        <WoWsTouchable onPress={this.changeTheme}>
          <View style={[viewStyle, {backgroundColor: this.colour}]}>
            <Text style={textStyle}>{this.colour}</Text>
          </View>
        </WoWsTouchable>        
      </View>
    )
  }

  changeTheme = () => {
    global.themeColour = this.colour;
    store.save(localDataName.themeColour, this.colour);
    Actions.pop();
    // Reset this app
    setTimeout(() => {
      this.props.reset(this.colour);
    }, 1000)
  }
}

const { viewStyle, textStyle } = styles

export {ThemeCell};