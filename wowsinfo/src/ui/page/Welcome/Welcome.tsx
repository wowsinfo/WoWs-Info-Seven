import { WoWsComponent, WoWsState } from '../../component/WoWsComponent';
import { Component } from 'react';
import { Surface, Text } from 'react-native-paper';

interface WelcomeState extends WoWsState {

}

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
        <Surface>
          <Text>Welcome to WoWs Info</Text>
        </Surface>
      )
    }
  }
}

export { Welcome };
