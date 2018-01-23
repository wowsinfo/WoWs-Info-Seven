import React from 'react';
import { View, Text, TextInput, FlatList, Keyboard, SafeAreaView, Alert } from 'react-native';
import { SearchField, SwitcherButton, WoWsTouchable, SearchResultCell, SearchSegment, ClanResultCell } from '../../component';
import { PlayerSearch, ClanSearch, ServerManager, ThisIsiPhoneX } from '../../core';
import { Actions } from 'react-native-router-flux';
import store from 'react-native-simple-store';
import strings from '../../localization';
import { localDataName } from '../../constant/value';

var SearchTimer;
class SearchScreen extends React.PureComponent {
  constructor(props) {
    super();
    this.state = {
      showPlayerList: true,
      player: true,
      data: [],
    }
    this.index = 0;
    let serverList = [{label: strings.russia, func: () => this.updateServer(0)},
      {label: strings.europe, func: () => this.updateServer(1)}, {label: strings.north_america, func: () =>  this.updateServer(2)},
      {label: strings.asia, func: () => this.updateServer(3)}, {label: strings.china, func: () => this.updateServer(4)}]
    
    Actions.refresh({
      renderTitle: <SearchSegment tabPress={this.changeSearchMode} selectedIndex={this.index}/>,
      right: <SwitcherButton data={serverList} imageStyle={{height: 24, width: 24, tintColor: 'white'}}/>
    })
  }

  componentWillMount() {
    this.setState({
      data: this.loadFriendList()
    })
  }

  updateServer(index) {
    global.server = index;
    store.save(localDataName.currServer, index);
    this.setState({data: []});
  }

  loadFriendList() {
    var info = []; var hasHenry = false;
    for (key in global.playerList) {
      if (key == '2011774448') {
        hasHenry = true; continue;
      }
      info.push(global.playerList[key]);
    }
    if (hasHenry) info.push({name: 'HenryQuan', id: '2011774448', server: '3'});
    return info.reverse();
  }

  keyExtractor = (item) => {return item.id}
  render() {
    const { player, showPlayerList, data } = this.state;
    if (player) {
      if (showPlayerList) {
        // Before typing anything
        return (
          <SafeAreaView>
            <SearchField onEndEditing={this.searchPlayer}/>
            <FlatList data={data} keyExtractor={this.keyExtractor} onScrollBeginDrag={Keyboard.dismiss}
              renderItem={({item}) => <SearchResultCell data={item}/>}/>
          </SafeAreaView>
        )
      } else {
        // After typing somethins    
        return (
          <SafeAreaView>
            <SearchField onEndEditing={this.searchPlayer}/>
            <FlatList data={data} keyExtractor={this.keyExtractor} onScrollBeginDrag={Keyboard.dismiss}
              renderItem={({item}) => <SearchResultCell data={item}/>} ref='listRef'/>
          </SafeAreaView>
        )
      }
    } else {
      // This is for clan
      return (
        <SafeAreaView>
          <SearchField onEndEditing={this.searchClan}/>
          <FlatList data={data} keyExtractor={this.keyExtractor} onScrollBeginDrag={Keyboard.dismiss}
            renderItem={({item}) => <ClanResultCell data={item}/>} ref='listRef'/>
        </SafeAreaView>
      );
    }
  }

  searchPlayer = (event) => {
    // Real time request
    this.setState({showPlayerList: false});  
    let input = event.nativeEvent.text.split(' ').join('');
    if (input.length > 2) {
      // Scroll to top for new results
      this.refs.listRef.scrollToOffset({animated: true, offset: 0});
      let request = new PlayerSearch(global.server, input);
      request.Search().then(result => {
        this.setState({
          data: result,
        }, Keyboard.dismiss)
      })
    }
  }

  searchClan = (event) => {  
    let input = event.nativeEvent.text.split(' ').join('');
    if (input.length > 1) {
      // Scroll to top for new results
      this.refs.listRef.scrollToOffset({animated: true, offset: 0});
      let request = new ClanSearch(global.server, input);
      request.Search().then(result => {
        this.setState({
          data: result,
        }, Keyboard.dismiss)
      })
    }
  }

  changeSearchMode = () => {
    if (this.index == 0) {
      this.index = 1;
      Actions.refresh({
        renderTitle: <SearchSegment tabPress={this.changeSearchMode} selectedIndex={this.index}/>,
      })
      this.setState({player: false, data: []})
    } else {
      this.index = 0;
      Actions.refresh({
        renderTitle: <SearchSegment tabPress={this.changeSearchMode} selectedIndex={this.index}/>,
      })
      this.setState({player: true, showPlayerList: true, data: this.loadFriendList()})
    }
  }
}

export {SearchScreen};