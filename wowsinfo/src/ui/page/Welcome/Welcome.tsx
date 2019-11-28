import { WoWsComponent, WoWsState } from '../../component/WoWsComponent';
import React, { Component } from 'react';
import { Surface, Text, Headline, Paragraph, Button } from 'react-native-paper';
import { AppLogo } from '../../component';
import { StyleSheet } from 'react-native';
import { Actions } from 'react-native-router-flux';

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
    const { rootView, welcomeView, stepView, bottomBtn } = styles;
    if (!this.state.loading) {
      return (
        <Surface style={rootView}>
          <Surface style={welcomeView}>
            <AppLogo />
            <Headline>Welcome to WoWs Info</Headline>
          </Surface>
          <Surface style={stepView}>
            <Paragraph>1......................</Paragraph>
            <Paragraph>2......................</Paragraph>
            <Paragraph>3......................</Paragraph>
          </Surface>
          <Button style={bottomBtn} onPress={() => Actions.replace('Agreement')}>Next</Button>
        </Surface>
      )
    }
  }
}

const styles = StyleSheet.create({
  rootView: {
    flex: 1,
    justifyContent: 'space-around'
  },
  welcomeView: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  stepView: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'flex-start'
  },
  bottomBtn: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    margin: 16
  }
});

export { Welcome };
