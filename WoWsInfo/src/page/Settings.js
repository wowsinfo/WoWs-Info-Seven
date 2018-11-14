import React, { Component } from 'react';
import { View, ScrollView, SafeAreaView, StyleSheet } from 'react-native';
import { Surface, List, Button, Caption, Checkbox, Colors, Divider } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';
import { BackButton, WoWsInfo } from '../component';

class Settings extends Component {
  render() {
    const { container, bottom } = styles;
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
            <Divider />
            <List.Section title='Theme'>
              <List.Item title='Dark Theme' right={() => <Checkbox status='checked'/>}/>
              <List.Item title='Tint Colour' right={() => <View style={{height: 36, width: 36, backgroundColor: Colors.blue500}}/>}/>              
              <Caption style={{paddingLeft: 16}}>Please restart WoWs Info to apply the new theme</Caption>
            </List.Section>
            <Divider />
            <List.Section title='WoWs Info'>
              <List.Item title='Feedback' description='Send email to developer'/>
              <List.Item title='Write a review' />
              <List.Item title='Share with friends'/>
              <Divider />
              <List.Item title='Github' description='https://github.com/HenryQuan/WoWs-Info'/>
              <List.Item title='Licences' description='Many libraries are used for building WoWs Info'/>
              <Divider />
              <List.Item title='Support Development' description='v1.0.6'/>
            </List.Section>
            <WoWsInfo />
          </ScrollView>
        </SafeAreaView>
        <BackButton />
      </Surface>
    )
  };
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
  }
});

export { Settings };
