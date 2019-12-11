import React, { Component } from 'react';
import { WoWsComponent, WoWsState, SetupProps } from '../../../component/WoWsComponent';
import { Surface, Title, Caption, Appbar } from 'react-native-paper';
import { StyleSheet, ScrollView } from 'react-native';
import { ContainedButton } from '../../../component';
import { Actions } from 'react-native-router-flux';
import { langs } from '../../../../core/value/Language';

export interface SettingsProps extends SetupProps {

}

interface SettingsState extends WoWsState {

}

class Settings extends Component<SettingsProps, SettingsState> implements WoWsComponent {
  isProFeature: boolean = false;

  constructor(props: SettingsProps) {
    super(props);
  }
  
  render() {
    const { rootView } = styles;

    const setup: SetupProps = {
      isSetup: true
    };

    return (
      <Surface style={rootView}>
        <Appbar.Header>
          { this.props.isSetup ? null : <Appbar.BackAction /> }
          <Appbar.Content title='Setup WoWs Info' />
        </Appbar.Header>
        <ScrollView>
          <Title>{langs.setup_language_title}</Title>
          <Title>{langs.setup_server_title}</Title>
          <Title>{langs.setup_wiki_language_title}</Title>
          <Caption>{langs.setup_wiki_language_caption}</Caption>
        </ScrollView>
        <ContainedButton onPress={() => Actions.replace('ProVersion', setup)}>
          {langs.setup_next_button}
        </ContainedButton>
      </Surface>
    );
  }

}

const styles = StyleSheet.create({
  rootView: {
    flex: 1
  },
  ContainedButton: {
    margin: 8
  }
});

export { Settings };
