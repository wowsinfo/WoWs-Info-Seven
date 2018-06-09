import React, { Component } from 'react';
import { StyleSheet } from 'react-native';
import language from '../../constant/language';
import SelectInput from 'react-native-select-input-ios';

class QuickInput extends Component {
  render() {
    const { viewStyle, textStyle } = styles;
    const { options, value, action } = this.props;
    return (
      <SelectInput style={android ? viewStyle : textStyle} labelStyle={android ? viewStyle : textStyle} cancelKeyText={language.settings_cancel} submitKeyText={language.settings_done}
        options={options} value={value} mode='dropdown' onSubmitEditing={action}/>
    )
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    padding: 8, flex: 1
  },
  textStyle: {
    padding: 8, color: 'black', flex: 1,
    fontSize: 16, fontWeight: '300'
  }
})

export { QuickInput };