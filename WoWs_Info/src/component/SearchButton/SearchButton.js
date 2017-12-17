import React from 'react';
import { styles, buttonIcon } from './Styles';
import { Button } from 'react-native-elements'; 

const { buttonStyle } = styles;
class SearchButton extends React.PureComponent {
  render() {
    return (
      <Button icon={buttonIcon} buttonStyle={buttonStyle} onPress={this.props.onPress}/>
    )
  }
}

export {SearchButton};