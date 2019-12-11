import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

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
    const { container } = styles;
    return (
      <View style={container}>
        <Text>Account</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  }
});

export { Account };
