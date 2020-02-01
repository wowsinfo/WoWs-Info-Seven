import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Button, Colors, Appbar } from 'react-native-paper';
import { ConsumerForAll } from '../../../component';
import { UserTheme } from '../../../../core/model';

export interface WikiProps {

}

interface WikiState {

}

/**
 * Wiki Class
 */
class Wiki extends Component<WikiProps, WikiState> {
  constructor(props: WikiProps) {
    super(props);
  }

  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Appbar.Header>
          <Appbar.Content title='Wikipedia' />
        </Appbar.Header>
        <ConsumerForAll>
          { c => (
            <>
            <Button onPress={() => c?.updateTheme(new UserTheme(true, Colors.red500))}>Dark Red</Button>
            <Button onPress={() => c?.updateTheme(new UserTheme(false, Colors.yellow500))}>Light Yellow</Button>
            <Button onPress={() => c?.updateTheme(new UserTheme(false, Colors.blue500))}>Light Blue</Button>
            </>
          )}
        </ConsumerForAll>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  }
});

export { Wiki };
