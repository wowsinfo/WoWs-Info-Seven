import React from 'react';
import { View, FlatList } from 'react-native';
import { ThemeCell } from '../../component';
import { WoWsInfo } from '../../colour/colour';

class ThemeScreen extends React.PureComponent {
  componentWillMount() {
    this.colourList = [WoWsInfo.black, WoWsInfo.blue, WoWsInfo.brown, WoWsInfo.cyan, WoWsInfo.green, WoWsInfo.orange,
      WoWsInfo.purple, WoWsInfo.red, WoWsInfo.yellow];
  }

  keyExtractor = (item) => {return item}  
  render() {
    return (
      <View style={{flex: 1}}>
        <FlatList data={this.colourList} keyExtractor={this.keyExtractor} 
          renderItem={({item}) => <ThemeCell reset={this.props.reset} colour={item}/>} />
      </View>
    )
  }
}

export {ThemeScreen};