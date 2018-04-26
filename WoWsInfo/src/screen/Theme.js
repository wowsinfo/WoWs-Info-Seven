import React, { Component } from 'react';
import { FlatList } from 'react-native';
import { ThemeCell } from '../component';
import { BLUE, RED, GREEN, PINK, PURPLE, DEEPPRUPLE, INDIGO, LIGHTBLUE, CYAN, TEAL, LIGHTGREEN, LIME, YELLOW, AMBER, ORANGE, DEEPORANGE, BROWN, GREY, BLUEGREY } from 'react-native-material-color';

export default class ThemeScreen extends Component {
  constructor() {
    super();
    this.colourList = [RED, PINK, PURPLE, DEEPPRUPLE, INDIGO, BLUE, LIGHTBLUE, CYAN, TEAL, GREEN, LIGHTGREEN, LIME, 
      YELLOW, AMBER, ORANGE, DEEPORANGE, BROWN, GREY, BLUEGREY];
  }

  keyExtractor = (item, index) => String(index)
  render() {
    return (
      <FlatList data={this.colourList} keyExtractor={this.keyExtractor} 
        renderItem={({item}) => <ThemeCell colour={item}/>} />
    )
  }
}