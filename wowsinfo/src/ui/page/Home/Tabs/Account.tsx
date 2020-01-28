import React, { Component } from 'react';
import { StyleSheet } from 'react-native';
import { Text, Headline, Title, Button, Surface } from 'react-native-paper';

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
    const { container, buttonView, titleView, userView } = styles;
    return (
      <Surface style={container}>
        <Surface style={titleView}>
          <Text>WoWs Info RE</Text>
        </Surface>
        <Surface style={userView}>
          <Title>Welcome Back</Title>
          <Headline>HenryQuan</Headline>
        </Surface>
        <Surface style={buttonView}>
          <Button mode='contained'>Check my statistics</Button>
          <Button >Check latest news</Button>
        </Surface>
      </Surface>
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
    width: '100%'
  },
  userView: {
    alignItems: 'center'
  },
  buttonView: {
    width: '61.8%',
    maxWidth: 300,
  }
});

export { Account };
