/**
 * Loading.js
 * 
 * The loading screen with loading animation
 */

import React, { Component } from 'react';
import { StatusBar, Image, StyleSheet, ActivityIndicator } from 'react-native';
import { Surface } from 'react-native-paper';
import { BLUE } from 'react-native-material-color';
import { lang } from '../../value/lang';

class Loading extends Component {
  constructor(props) {
    super(props);

    // this.state = {
    //   text: ''
    // };

    // let charArray = lang.setup_loading.split('');
    // setInterval(() => {
    //   const { text } = this.state;
    //   if (text.length === charArray.length) {
    //     this.setState({text: ''});
    //   } else {
    //     this.setState({text: text + charArray[text.length]});
    //   }
    // }, 50);
  }

  componentWillUnmount() {
    // clearInterval();
  }

  render() {
    const { container, logo, label } = styles;

    return (
      <Surface style={container}>
        {/* <StatusBar backgroundColor={BLUE[700]}/> */}
        <Image style={logo} source={require('../../img/Logo.png')}/>
        <ActivityIndicator size='large' color='white'/>
      </Surface>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: BLUE[500]
  },
  logo: {
    tintColor: 'white'
  },
  label: {
    color: 'white'
  }
});

export { Loading };
