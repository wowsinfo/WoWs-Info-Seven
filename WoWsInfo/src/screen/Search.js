import React, { Component } from 'react'
import * as Animatable from 'react-native-animatable';
import { View, Text, TextInput } from 'react-native';

export default class Search extends Component {
  render() {
    return (
      <Animatable.View animation='fadeInLeft'>
        <Text>Hello World</Text>
      </Animatable.View>
    )
  }
}