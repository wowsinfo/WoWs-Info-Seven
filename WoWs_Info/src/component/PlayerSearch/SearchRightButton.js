import React from 'react';
import ModalDropdown from 'react-native-modal-dropdown';
import strings from '../../localization';
import { ServerManager } from '../../core';
import { localDataName } from '../../constant/value';
import store from 'react-native-simple-store';
import { styles } from './SearchRightButtonStyles';

class SearchRightButton extends React.PureComponent {
  constructor() {
    super();
    this.index = global.server;
    this.selectedServer = ServerManager.getCurrName(this.index);
    this.options = [strings.russia, strings.europe, strings.north_america, strings.asia];
  }

  render() {
    const { buttonStyle, dropdownStyle, dropdownTextStyle } = styles;
    return (
      <ModalDropdown defaultValue={this.selectedServer} options={this.options} 
        textStyle={buttonStyle} dropdownStyle={dropdownStyle} dropdownTextStyle={dropdownTextStyle} 
        onSelect={this.valueChanged} showsVerticalScrollIndicator={false}/>
    )
  }

  valueChanged = (index, value) => {
    // Update server index
    global.server = index;
    store.save(localDataName.currServer, index);
    this.props.reset();
  }
}

export {SearchRightButton};