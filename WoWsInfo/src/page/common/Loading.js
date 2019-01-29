/**
 * Loading.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, Image, Text, StyleSheet } from 'react-native';
import { Surface } from 'react-native-paper';
import { ThemeBackColour } from '../../value/colour';
import { Blue } from 'react-native-material-color';
import lang from '../../value/lang';

class Loading extends Component {
  constructor(props) {
    super(props);

    this.state = {
      text: ''
    };

    let charArray = lang.setup_loading.split('');
    setInterval(() => {
      const { text } = this.state;
      if (text.length === charArray.length) {
        this.setState({text: ''});
      } else {
        this.setState({text: text + charArray[text.length]});
      }
    }, 50);
  }

  componentWillUnmount() {
    clearInterval();
  }

  render() {
    const { container, logo, label } = styles;
    const { text } = this.state;

    return (
      <Surface style={container}>
        <Image style={logo} source={require('../../img/Logo.png')}/>
        <Text style={label}>{` ${text} `}</Text>
      </Surface>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: Blue
  },
  logo: {
    tintColor: 'white'
  },
  label: {
    color: 'white'
  }
});

export { Loading };
