import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { Text, Headline, Title, Button, IconButton, Colors, Caption } from 'react-native-paper';
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
      <View style={container}>
        { this.renderHeader() }
        <View style={userView}>
          <Headline style={greetingText}>Welcome Back</Headline>
          <Title style={userText}>HenryQuan</Title>
        </View>
        <View style={buttonView}>
          <Button mode='contained'>Check my statistics</Button>
          <Button>Check latest news</Button>
        </View>
      </View>
    );
  }

  renderHeader() {
    const { titleView, titleTextView } = styles;
    return (
      <ConsumerForAll>
        { c => 
          <View style={titleView}>
            <IconButton icon={require('../../../../assets/Logo.png')} 
              size={64} color={c?.theme.getPrimary()} style={{margin: -16}}/>
            <View style={titleTextView}>
              <Title>WoWs Info RE</Title>
              <Caption>1.1.0 (0.9.0.0)</Caption>
            </View>
            <IconButton icon='settings'
              size={32} color={c?.theme.getPrimary()} style={{margin: -8}}/>
          </View>
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
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center'
  },
  titleTextView: {
    flex: 1,
    marginLeft: -32,
    zIndex: -1,
    alignItems: 'center'
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
