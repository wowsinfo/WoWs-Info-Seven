import { WoWsComponent, WoWsState } from '../../component/WoWsComponent';
import React, { Component } from 'react';
import { Surface, Text, Headline, Paragraph, Button, Title } from 'react-native-paper';
import { AppLogo, BottomButton } from '../../component';
import { StyleSheet } from 'react-native';
import { Actions } from 'react-native-router-flux';
import { langs, languageAvailable } from '../../../core/value/Language';

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

    langs.setLanguage(languageAvailable.ja);
  }

  render() {
    const { rootView, welcomeView, logoView } = styles;
    if (!this.state.loading) {
      return (
        <Surface style={rootView}>
          <Surface style={logoView}>
            <AppLogo />
          </Surface>
          <Surface style={welcomeView}>
            <Headline>{langs.welcome_to_wows_info}</Headline>
          </Surface>
          <BottomButton onPress={() => Actions.replace('Agreement')}>
            {langs.welcome_next_button}
          </BottomButton>
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
