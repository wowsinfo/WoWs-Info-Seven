import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Appbar } from 'react-native-paper';

export interface RSProps {

}

interface RSState {

}

/**
 * RS Class
 */
class RS extends Component<RSProps, RSState> {
  constructor(props: RSProps) {
    super(props);
  }

  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Appbar.Header>
          <Appbar.Content title='Real-time statistics' />
        </Appbar.Header>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  }
});

export { RS };
