import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Searchbar, Appbar } from 'react-native-paper';

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
        <Appbar.Header>
          <Searchbar />
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

export { Search };
