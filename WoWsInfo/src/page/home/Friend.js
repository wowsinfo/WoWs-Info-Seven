import React, { PureComponent } from 'react';
import { View, StyleSheet, FlatList } from 'react-native';
import { List, Text, Colors, IconButton } from 'react-native-paper';
import { LOCAL } from '../../value/data';
import { SafeAction } from '../../core';

class Friend extends PureComponent {
  constructor(props) {
    super(props);
    this.state = {
      list: DATA[LOCAL.friendList]
    };
  }

  render() {
    const { container } = styles;
    const { list } = this.state;
    return (
      <View style={container}>
        <FlatList data={list} renderItem={({item, index}) => 
          <List.Item key={item.nickname} title={item.nickname} onPress={() => this.navigate(item)}
            right={() => <IconButton color={Colors.grey500} icon='close' onPress={() => this.removeFriend(item, index)}/> }/>}
          keyExtractor={i => i.account_id} showsVerticalScrollIndicator={false}/>
      </View>
    )
  };

  removeFriend(item, index) {
    let str = LOCAL.friendList;
    let friend = DATA[str];
  }

  /**
   * Navigate to player page with necessary information
   * @param {any} info 
   */
  navigate(info) {
    SafeAction('Statistics', {info: info, friend: true})
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingBottom: 32
  }
});

export { Friend };
