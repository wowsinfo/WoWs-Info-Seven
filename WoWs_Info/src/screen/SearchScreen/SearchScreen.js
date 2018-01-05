import React from 'react';
import { View, Text, TextInput, FlatList, Keyboard, SafeAreaView } from 'react-native';
import { SearchHeader, SearchRightButton, WoWsTouchable, SearchResultCell, PlayerListCell } from '../../component';
import { PlayerSearch } from '../../core';
import { Actions } from 'react-native-router-flux';

var SearchTimer;
class SearchScreen extends React.PureComponent {
  state = {
    showPlayerList: true,
    player: true,
    data: global.playerList,
  }

  constructor() {
    super();
    Actions.refresh({
      renderTitle: <SearchHeader onChangeText={this.searchPlayer}/>, 
      right: <SearchRightButton reset={this.clearResult}/>
    })
  }

  keyExtractor = (item) => {return item.nickname}  
  listExtractor = (item) => { console.log(item); return item.id}  
  render() {
    const { player, showPlayerList, data } = this.state;
    if (player) {
      if (showPlayerList) {
        // Before typing anything
        return (
          <SafeAreaView>
            <FlatList data={data} keyExtractor={this.listExtractor}
              renderItem={(item) => <PlayerListCell data={item}/>}/>
          </SafeAreaView>
        )
      } else {
        // After typing somethins
        return (
          <SafeAreaView>
            <FlatList data={data} keyExtractor={this.keyExtractor} onScrollBeginDrag={Keyboard.dismiss}
              renderItem={({item}) => <SearchResultCell data={item}/>} ref='listRef'/>
          </SafeAreaView>
        )
      }
    } else {
      // This is for clan
      return null;
    }
  }

  searchPlayer = (text) => {
    // Real time request
    this.setState({showPlayerList: false});    
    let input = text.split(' ').join('');
    if (input.length < 3) clearTimeout(SearchTimer);
    else {
      clearTimeout(SearchTimer);
      SearchTimer = setTimeout(() => {
        // Scroll to top for new results
        this.refs.listRef.scrollToOffset({animated: true, offset: 0});
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