import React, { Component } from 'react';
import { FlatList } from 'react-native';
import { ThemeCell } from '../../component';
import { BLUE, RED, GREEN, PINK, PURPLE, DEEPPRUPLE, INDIGO, LIGHTBLUE, CYAN, TEAL, LIGHTGREEN, LIME, YELLOW, AMBER, ORANGE, DEEPORANGE, BROWN, GREY, BLUEGREY } from 'react-native-material-color';

export default class ThemeScreen extends Component {
  constructor() {
    super();
    let WHITE = { 500: '#ffffff', 700: '#ffffff' };
    let BLACK = { 500: '#212121', 700: '#212121' };
    this.colourList = [RED, PINK, PURPLE, DEEPPRUPLE, INDIGO, BLUE, LIGHTBLUE, CYAN, TEAL, GREEN, LIGHTGREEN, LIME, 
      YELLOW, AMBER, ORANGE, DEEPORANGE, BROWN, GREY, BLUEGREY, BLACK, WHITE];
  }

  static navigatorStyle = {
    tabBarHidden: true
  }

  keyExtractor = (item, index) => String(index)
  render() {
    return (
      <FlatList data={this.colourList} keyExtractor={this.keyExtractor}
        renderItem={({item}) => <ThemeCell colour={item}/>} />
    )
  }
}