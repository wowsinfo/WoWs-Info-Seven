import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Button, Colors } from 'react-native-paper';
import { ConsumerForAll } from '../../../component';
import { CustomTheme } from '../../../../core/model';

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
        <ConsumerForAll>
          { c => (
            <Button onPress={() => c?.updateTheme(new CustomTheme(true, Colors.red500))}>Hello</Button>
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
