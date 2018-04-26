import React, { Component } from 'react'
import * as Animatable from 'react-native-animatable';
import { View, Button } from 'react-native';
import { WoWsLoading } from '../component';

export default class Search extends Component {
  constructor(props) {
    super();
    props.navigator.setOnNavigatorEvent(this.onNavigatorEvent.bind(this));
  }

  onNavigatorEvent(event) {
    if (event.type == 'NavBarButtonPress') {
      if (event.id == 'drawer') {
       
      }
    }
  }

  render() {
    return (
      <View style={{flex: 1}}>
      </View>
    )
  }
}