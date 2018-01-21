import React from 'react';
import { View, Text, TextInput, FlatList, Keyboard, SafeAreaView } from 'react-native';
import { SearchField, SearchRightButton, WoWsTouchable, SearchResultCell, SearchSegment } from '../../component';
import { PlayerSearch } from '../../core';
import { Actions } from 'react-native-router-flux';

var SearchTimer;
class SearchScreen extends React.PureComponent {
  constructor(props) {
    super();
    this.state = {
      showPlayerList: true,
      player: true,
      data: [],
    }

    Actions.refresh({
      renderTitle: <SearchSegment />,
      right: <SearchRightButton reset={this.clearResult}/>
    })
  }

  componentWillMount() {
    var info = []; var hasHenry = false;
    for (key in global.playerList) {
      if (key == '2011774448') {
        hasHenry = true; continue;
      }
      info.push(global.playerList[key]);
    }
    if (hasHenry) info.push({name: 'HenryQuan', id: '2011774448', server: '3'});
    this.setState({
      data: info.reverse(),
    })
  }

  keyExtractor = (item) => {return item.id}
  render() {
    const { player, showPlayerList, data } = this.state;
    if (player) {
      if (showPlayerList) {
        // Before typing anything
        return (
          <SafeAreaView>
            <SearchField onChangeText={this.searchPlayer}/>
            <FlatList data={data} keyExtractor={this.keyExtractor} onScrollBeginDrag={Keyboard.dismiss}
              renderItem={({item}) => <SearchResultCell data={item}/>}/>
          </SafeAreaView>
        )
      } else {
        // After typing somethins    
        return (
          <SafeAreaView>
            <SearchField onChangeText={this.searchPlayer}/>
            <FlatList data={data} keyExtractor={this.keyExtractor} onScrollBeginDrag={Keyboard.dismiss}
              renderItem={({item}) => <SearchResultCell data={item}/>} ref='listRef'/>
          </SafeAreaView>
        )
      }
    } else {
      // This is for clan
      return (
        <SafeAreaView>
          <SearchField onChangeText={this.searchPlayer}/>
          <FlatList data={data} keyExtractor={this.keyExtractor} onScrollBeginDrag={Keyboard.dismiss}
            renderItem={({item}) => <SearchResultCell data={item}/>} ref='listRef'/>
        </SafeAreaView>
      );
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

  searchClan = (text) => {
    
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