import React, { Component } from 'react';
import { Surface, Text, Headline, Paragraph, Button, Title, Appbar, Caption } from 'react-native-paper';
import { StyleSheet } from 'react-native';
import { Actions } from 'react-native-router-flux';
import { SetupProps, WoWsState, WoWsComponent } from 'src/ui/component/WoWsComponent';
import { AppLogo, ContainedButton } from 'src/ui/component';
import Utils from 'src/core/Utils';
import { langs } from 'src/core/value/Language';

export interface AboutProps extends SetupProps {

}

interface AboutState extends WoWsState {

}

/**
 * The first welcome page and it has some basic greetings from me
 */
class About extends Component<AboutProps, AboutState> implements WoWsComponent {
  isProFeature: boolean = false;
  headerTitle: String = 'About WoWs Info'

  constructor(props: AboutProps) {
    super(props);

    if (props.isSetup) {
      this.headerTitle = 'Welcome'
    }

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
            {this.props.isSetup ? null : <Appbar.BackAction />}
            <Appbar.Content title={this.headerTitle} />
          </Appbar.Header>
          <Surface style={logoView}>
            <AppLogo size={128} />
            <Text>{Utils.getCurrentVersion()}</Text>
          </Surface>
          <Surface style={welcomeView}>
            <Headline>{langs.welcome_to_wows_info}</Headline>
          </Surface>
          {this.renderNextButton()}
        </Surface>
      )
    }
  }

  /**
   * It render a next button only if it is in setup mode
   */
  renderNextButton() {
    if (this.props.isSetup) {
      return (
        <ContainedButton onPress={() => Actions.replace('Agreement')}>
          {langs.welcome_next_button}
        </ContainedButton>
      );
    }

    return null;
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

export { About };
