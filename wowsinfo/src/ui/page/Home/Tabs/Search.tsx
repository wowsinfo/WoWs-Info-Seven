import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Searchbar, Appbar } from 'react-native-paper';
import { ConsumerForAll } from 'src/ui/component';

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
        { this.renderSearch() }
      </View>
    );
  }

  renderSearch = () => {
    const { search } = styles;
    return (
      <ConsumerForAll>
        { c => {
          const theme = c!.theme;
          const textColour = theme.getTextColour();
          const placeHolderColour = theme.getPlaceholderColour();
          return (
            <Appbar.Header>
              <Searchbar style={search} iconColor={textColour} placeholderTextColor={placeHolderColour}
                selectionColor={textColour} placeholder='Search players or clans'/>
            </Appbar.Header>
          );
        }}
      </ConsumerForAll>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  },
  search: {
    backgroundColor: 'transparent', 
    elevation: 0
  }
});

export { Search };
