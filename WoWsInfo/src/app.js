import React, { Component } from 'react';
import { StyleSheet, Text, StatusBar, SafeAreaView, ScrollView, View } from 'react-native';
import { Surface, Appbar, IconButton, Colors } from 'react-native-paper';

export default class App extends Component {
  render() {
    const { container, playerLabel, header } = styles;
    return (
      <View style={container}>
        <StatusBar />
        <SafeAreaView style={{height: '100%'}}>
          <ScrollView>
            <View style={header}>
              <Text style={playerLabel}>HenryQuanYiheng</Text>
              <IconButton icon='settings' size={24} color={Colors.grey500}
                onPress={() => console.log('Pressed')}/>
            </View>
          </ScrollView>
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
    height: '100%', 
    flexDirection: 'row', 
    justifyContent: 'space-between'
  },
  playerLabel: {
    fontSize: 32,
    fontWeight: 'bold'
  }
});
