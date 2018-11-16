import React, { Component } from 'react';
import { StyleSheet, View, SafeAreaView, ScrollView } from 'react-native';
import { IconButton, Text, Colors, Surface, 
  Card, Title, Paragraph, Button } from 'react-native-paper';
import { FloatingButton } from '../../component';
import { Actions } from 'react-native-router-flux';
import { GREY } from 'react-native-material-color';

class Home extends Component {
  constructor(props) {
    super(props);

    this.state = {
      // there are three tabs (statistics, friends and rs)
      tab: 'statistics'
    }
  }

  render() {
    const { container, playerLabel, header, bottom } = styles;
    return (
      <Surface theme={{colors: {background: GREY[800]}}} style={container}>
        <SafeAreaView style={{height: '100%'}}>
          <Surface style={header}>
            <Text numberOfLines={1} style={playerLabel}>HenryQuan</Text>
            <IconButton icon='settings' size={24} color={Colors.grey500}
              onPress={() => Actions.Settings()}/>
          </Surface>
          <ScrollView contentContainerStyle={{flex: 1, padding: 8}}>
            <Text>Hello</Text>
          </ScrollView>
          <FloatingButton />
        </SafeAreaView>
      </Surface>
    );
  }

  /**
   * This is the stats part and it is basically a player stat screen
   */
  renderStatistics() {

  }

  /**
   * A simple list with friends
   */
  renderFriends() {

  }

  /**
   * This is the beta version of real stat
   */
  renderRS() {

  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    width: '100%', 
    flexDirection: 'row', 
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 8
  },
  playerLabel: {
    fontSize: 32,
    padding: 8,
    width: '80%',
    fontWeight: 'bold'
  },
  bottom: {
    flexDirection: 'row',
    justifyContent: 'space-around'
  }
});

export { Home };
