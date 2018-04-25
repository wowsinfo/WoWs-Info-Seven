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
        this.props.navigator.toggleDrawer({
          side: 'left', to: 'open',
          animated: true
        });
      }
    }
  }

  render() {
    return (
      <View>
        <Button title='search' onPress={() => this.props.navigator.showLightBox({
          screen: 'info.Drawer',
          title: 'HenryQuan',
          backButtonTitle: '',
          style: {
            backgroundBlur: 'dark',
            tapBackgroundToDismiss: true
          },
          })}/>
      </View>
    )
  }
}