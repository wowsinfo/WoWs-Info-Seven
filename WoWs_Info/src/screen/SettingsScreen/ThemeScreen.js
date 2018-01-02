import React from 'react';
import { View, FlatList } from 'react-native';
import { ThemeCell } from '../../component';
import { WoWsInfo } from '../../colour/colour';

class ThemeScreen extends React.PureComponent {
  componentWillMount() {
    var colourList = [];
    for (key in WoWsInfo) colourList.push(WoWsInfo[key]);
    this.colourList = colourList;
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