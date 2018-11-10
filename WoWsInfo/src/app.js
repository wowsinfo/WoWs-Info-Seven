import React, { Component } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { Surface } from 'react-native-paper';

export default class App extends Component {
  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Surface>
          <Text>Hello</Text>
        </Surface>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  }
});
