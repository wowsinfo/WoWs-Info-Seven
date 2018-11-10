import React, { Component } from 'react';
import { StyleSheet, Text, StatusBar, SafeAreaView, ScrollView, View } from 'react-native';
import { IconButton, Colors, Divider } from 'react-native-paper';
import { MenuButton } from './component';

export default class App extends Component {
  render() {
    const { container, playerLabel, header } = styles;
    return (
      <View style={container}>
        <StatusBar />
        <SafeAreaView style={{height: '100%'}}>
          <View style={header}>
            <Text style={playerLabel}>HenryQuan</Text>
            <IconButton icon='settings' size={24} color={Colors.grey500}
              onPress={() => console.log('Pressed')}/>
          </View>
          <Divider/>
          <ScrollView>
            <Text>Hello</Text>
            <Text>Hello</Text>
            <Text>Hello</Text>
            <Text>Hello</Text>
            <Text>Hello</Text>
            <Text>Hello</Text>
            <Text>Hello</Text>
            <Text>Hello</Text>
            <Text>Hello</Text>
            <Text>Hello</Text>
            <Text>Hello</Text>
            <Text>Hello</Text>
            <Text>Hello</Text>
            <Text>Hello</Text>
            <Text>Hello</Text>
          </ScrollView>
          <MenuButton />
        </SafeAreaView>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 8
  },
  header: {
    width: '100%', 
    flexDirection: 'row', 
    justifyContent: 'space-between'
  },
  playerLabel: {
    fontSize: 32,
    fontWeight: 'bold'
  }
});
