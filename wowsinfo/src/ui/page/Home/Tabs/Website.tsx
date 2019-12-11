import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

export interface WebsiteProps {

}

interface WebsiteState {

}

/**
 * Website Class
 */
class Website extends Component<WebsiteProps, WebsiteState> {
  constructor(props: WebsiteProps) {
    super(props);
  }

  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Text>Website</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  }
});

export { Website };
