import React from 'react';
import { View, Text, TextInput, FlatList, Keyboard, SafeAreaView } from 'react-native';
import { SearchHeader, SearchRightButton, WoWsTouchable, SearchResultCell } from '../../component';
import { PlayerSearch } from '../../core';
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
      right: <SearchRightButton reset={this.clearResult}/>
    })        
  }

  keyExtractor = (item) => {return item.nickname}  
  render() {
    if (this.state.player) {
      if (this.state.showPlayerList) {
        // Before typing anything
        return null;
      } else {
        // After typing somethins
        return (
          <SafeAreaView>
            <FlatList data={this.state.data} keyExtractor={this.keyExtractor} onScrollBeginDrag={Keyboard.dismiss}
              renderItem={({item}) => <SearchResultCell data={item}/>}/>
          </SafeAreaView>
        )
      }
    } else {
      // This is for clan
      return null;
    }
  }

  searchPlayer = (text) => {
    this.setState({showPlayerList: false});
    // Real time request
    let input = text.split(' ').join('');
    if (input.length < 3) clearTimeout(SearchTimer);
    else {
      clearTimeout(SearchTimer);
      SearchTimer = setTimeout(() => {
        let request = new PlayerSearch(global.server, input);
        request.Search().then(result => {
          this.setState({
            data: result,
          }, Keyboard.dismiss)
        })
      }, 1250);
    }
  }

  clearResult = () => {
    this.setState({data: []});
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