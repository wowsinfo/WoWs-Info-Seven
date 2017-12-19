import React from 'react';
import { View, Text, TextInput, FlatList } from 'react-native';
import { SearchHeader, SearchRightButton, WoWsTouchable } from '../../component';
import { Actions } from 'react-native-router-flux';

var SearchTimer;
class SearchScreen extends React.PureComponent {
  state = {
    showPlayerList: true,
    player: true,
    data: [],
  }

  constructor() {
    super();
    Actions.refresh({
      renderTitle: <SearchHeader onChangeText={this.searchPlayer}/>, 
      right: <SearchRightButton />
    })        
  }

  searchPlayer = (text) => {
    this.setState({showPlayerList: false});
    // Real time request
    if (text.length < 3) clearTimeout(SearchTimer);
    else {
      clearTimeout(SearchTimer);
      SearchTimer = setTimeout(() => {
        console.log('Working');
      }, 1500);
    }
    
  }

  render() {
    if (this.state.player) {
      if (this.state.showPlayerList) {
        // Before typing anything
        return null;
      } else {
        // After typing somethins
      }
    } else {
      // This is for clan
    }
  }

  modeSwitcher() {
    // This is the button to switch mode
    return (
      <View>
        <WoWsTouchable>
          <Text></Text>
        </WoWsTouchable>
      </View>
    )
  }
}

export {SearchScreen};