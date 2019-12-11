import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

export interface SearchProps {

}

interface SearchState {

}

/**
 * Search Class
 */
class Search extends Component<SearchProps, SearchState> {
  constructor(props: SearchProps) {
    super(props);
  }

  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Text>Search</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  }
});

export { Search };
