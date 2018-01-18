import React from 'react';
import { Dropdown } from 'react-native-material-dropdown';
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
    this.options = [{value: strings.russia}, {value: strings.europe}, {value: strings.north_america}, {value: strings.asia}];
  }

  render() {
    const { buttonStyle, dropdownStyle, dropdownTextStyle } = styles;
    return (
      <Dropdown data={this.options} value={this.options[this.index].value} labelHeight={28} />
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