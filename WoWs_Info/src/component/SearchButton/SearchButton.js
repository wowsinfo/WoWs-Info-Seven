import React from 'react';
import { styles, sizeStyle } from './SearchButtonStyles';
import { Icon } from 'react-native-elements'; 

class SearchButton extends React.PureComponent {
  render() {
    const { buttonStyle } = styles;
    return (
      <Icon name='search' color='white' underlayColor='transparent' size={sizeStyle}
        type='evil-icons' containerStyle={buttonStyle} onPress={this.props.onPress}/>
    )
  }
}

export {SearchButton};