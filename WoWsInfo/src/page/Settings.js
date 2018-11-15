import React, { Component } from 'react';
import { View, ScrollView, SafeAreaView, StyleSheet, Linking, Share } from 'react-native';
import { isAndroid } from 'react-native-device-detection';
import { Surface, List, Button, Checkbox, Colors, withTheme } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';
import { BackButton, WoWsInfo, DividerPlus } from '../component';
import { APP } from '../value/data';

class Settings extends Component {
  render() {
    const { container, tint } = styles;
    const store = isAndroid ? APP.GooglePlay : APP.AppStore;
    return (
      <Surface style={container}>
        <SafeAreaView style={{flex: 1}}>
          <ScrollView>
            <List.Section title='API Settings'>
              <List.Accordion title='Game Server - ASIA'>
                <View style={{flexDirection: 'row', justifyContent: 'space-around'}}>
                  <Button>RU</Button>
                  <Button>EU</Button>
                  <Button>NA</Button>
                  <Button>ASIA</Button>
                </View>
              </List.Accordion>
              <List.Accordion title='API Language - English'>
                <ScrollView horizontal
                  contentContainerStyle={{flexDirection: 'row'}}>
                  <Button>RU</Button>
                  <Button>RU</Button>
                  <Button>RU</Button>
                  <Button>RU</Button>
                  <Button>RU</Button>
                  <Button>RU</Button>
                  <Button>RU</Button>
                  <Button>RU</Button>
                </ScrollView>
              </List.Accordion>
            </List.Section>
            <DividerPlus />
            <List.Section title='Theme'>
              <List.Item title='Dark Theme' onPress={() => this.updateTheme()} 
                right={() => <Checkbox status='checked'/>}/>
              <List.Item title='Tint Colour' 
                right={() => <View style={[tint, {backgroundColor: Colors.blue500}]}/>}/>              
            </List.Section>
            <DividerPlus />
            <List.Section title='WoWs Info'>
              <List.Item title='Feedback' description='Send email to developer'
                onPress={() => Linking.openURL(APP.Developer)}/>
              <List.Item title='Write a review' 
                onPress={() => Linking.openURL(store)}/>
              <List.Item title='Share with friends'
                onPress={() => Share.share({url: store})}/>
            </List.Section>
            <DividerPlus />
            <List.Section title='Open Source'>
              <List.Item title='Github' description='https://github.com/HenryQuan/WoWs-Info'/>
              <List.Item title='Licences' description='Many libraries are used for building WoWs Info'/>
            </List.Section>
            <WoWsInfo />
          </ScrollView>
        </SafeAreaView>
        <BackButton />
      </Surface>
    )
  };

  /**
   * Update app theme real time
   */
  updateTheme() {
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  },
  bottom: {
    position: 'absolute',
    left: 0,
    right: 0,
    bottom: 0,
  },
  tint: {
    height: 36, width: 36, 
    borderRadius: 18, 
  }
});

export default withTheme(Settings);
