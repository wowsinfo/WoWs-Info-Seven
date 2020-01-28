import React, { Component } from 'react';
import { StyleSheet } from 'react-native';
import { Text, Headline, Title, Button, Surface, IconButton, Colors } from 'react-native-paper';
import { ConsumerForAll } from '../../../component';

export interface AccountProps {

}

interface AccountState {

}

/**
 * Account Class
 */
class Account extends Component<AccountProps, AccountState> {
  constructor(props: AccountProps) {
    super(props);
  }

  render() {
    const { container, buttonView, userView, greetingText, userText } = styles;
    return (
      <Surface style={container}>
        { this.renderHeader() }
        <Surface style={userView}>
          <Headline style={greetingText}>Welcome Back</Headline>
          <Title style={userText}>HenryQuan</Title>
        </Surface>
        <Surface style={buttonView}>
          <Button mode='contained'>Check my statistics</Button>
          <Button>Check latest news</Button>
        </Surface>
      </Surface>
    );
  }

  renderHeader() {
    const { titleView, iconBtn } = styles;
    return (
      <ConsumerForAll>
        { c => 
          <Surface style={titleView}>
            <IconButton icon={require('../../../../assets/Logo.png')} 
              size={64} color={c?.theme.getPrimary()} style={iconBtn}/>
            <Text>WoWs Info RE</Text>
            <IconButton icon='settings'
              size={32} color={c?.theme.getPrimary()} style={iconBtn}/>
          </Surface>
        }
      </ConsumerForAll>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  titleView: {
    width: '100%',
    flexDirection: 'row'
  },
  iconBtn: {
    margin: -16,
  },
  userView: {
    alignItems: 'center',
    flex: 1,
    justifyContent: 'center'
  },
  greetingText: {
    fontSize: 24
  },
  userText: {
    fontSize: 32,
    textAlign: 'center',
  },
  buttonView: {
    width: '61.8%',
    maxWidth: 300,
  }
});

export { Account };
