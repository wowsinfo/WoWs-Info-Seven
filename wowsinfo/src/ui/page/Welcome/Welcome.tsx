import { WoWsComponent, WoWsState } from '../../component/WoWsComponent';
import React, { Component } from 'react';
import { Surface, Text, Headline, Paragraph, Button, Title, Appbar } from 'react-native-paper';
import { AppLogo, ContainedButton } from '../../component';
import { StyleSheet } from 'react-native';
import { Actions } from 'react-native-router-flux';
import { langs } from '../../../core/value/Language';

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
    const { rootView, welcomeView, logoView } = styles;
    if (!this.state.loading) {
      return (
        <Surface style={rootView}>
          <Appbar.Header>
            <Appbar.Content title='Welcome' />
          </Appbar.Header>
          <Surface style={logoView}>
            <AppLogo />
          </Surface>
          <Surface style={welcomeView}>
            <Headline>{langs.welcome_to_wows_info}</Headline>
          </Surface>
          <ContainedButton onPress={() => Actions.replace('Agreement')}>
            {langs.welcome_next_button}
          </ContainedButton>
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
  logoView: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  welcomeView: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'flex-start'
  },
});

export { Welcome };
