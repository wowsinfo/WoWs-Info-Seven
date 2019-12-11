import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

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
        <Text>Wiki</Text>
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
