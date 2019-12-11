import React, { Component } from 'react';
import { WoWsComponent, WoWsState } from '../../component/WoWsComponent';
import { Surface, Title, Caption } from 'react-native-paper';
import { StyleSheet } from 'react-native';
import { langs } from '../../../core/value/Language';
import { BottomButton } from '../../component';
import { Actions } from 'react-native-router-flux';

interface SettingsState extends WoWsState {

}

class Settings extends Component<{}, SettingsState> implements WoWsComponent {
  isProFeature: boolean = false;

  constructor(props: {}) {
    super(props);
    
  }
  
  render() {
    const { rootView } = styles;
    return (
      <Surface style={rootView}>
        <Title>{langs.setup_language_title}</Title>
        <Title>{langs.setup_server_title}</Title>
        <Title>{langs.setup_wiki_language_title}</Title>
        <Caption>{langs.setup_wiki_language_caption}</Caption>
        <BottomButton onPress={() => Actions.replace('ProVersion')}>
          {langs.setup_next_button}
        </BottomButton>
      </Surface>
    );
  }
}

const styles = StyleSheet.create({
  rootView: {
    flex: 1,
    padding: 16
  }
});

export { Settings };
