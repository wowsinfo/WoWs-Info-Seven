import React, { PureComponent } from 'react';
import { View, StyleSheet, FlatList } from 'react-native';
import { List, Text, Colors, IconButton } from 'react-native-paper';
import { LOCAL } from '../../value/data';

class Friend extends PureComponent {
  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <FlatList data={DATA[LOCAL.friendList]} renderItem={({item}) => 
          <List.Item title={item.name} onPress={() => this.navigate(item)}
          right={() => <IconButton color={Colors.grey500} icon='close'
            onPress={() => null}/> }/>}/>
      </View>
    )
  };

  /**
   * Navigate to player page with necessary information
   * @param {any} info 
   */
  navigate(info) {

  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingBottom: 32
  }
});

export { Friend };
