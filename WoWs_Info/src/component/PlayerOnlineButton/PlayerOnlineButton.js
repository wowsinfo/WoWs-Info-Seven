import React from 'react';
import { styles, sizeStyle } from './PlayerOnlineButtonStyles';
import { Icon } from 'react-native-elements'; 

class PlayerOnlineButton extends React.PureComponent {
  render() {
    const { buttonStyle } = styles;
    return (
      <Icon name='stop-circle' color='white' underlayColor='transparent' size={sizeStyle}
      type='feather' containerStyle={buttonStyle} onPress={this.props.onPress}/>
    )
  }
}

export {PlayerOnlineButton};