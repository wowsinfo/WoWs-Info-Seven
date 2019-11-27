import { WoWsComponent, WoWsState } from '../../component/WoWsComponent';
import React, { Component } from 'react';
import { Surface, Text, Appbar } from 'react-native-paper';

interface WelcomeState extends WoWsState {

}

/**
 * The first welcome page and it has some basic greetings from me
 */
class Welcome extends Component<{}, WelcomeState> implements WoWsComponent {
  isProFeature: boolean = false;

  constructor(props: {}) {
    super(props);
    this.state = {
      loading: false,
      error: ''
    }
  }

  render() {
    if (!this.state.loading) {
      return (
        <Surface style={{flex: 1}}>
          <Text>Hello World</Text>
        </Surface>
      )
    }
  }
}

export { Welcome };
