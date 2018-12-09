import React, { Component } from 'react';
import { View, ScrollView, SafeAreaView, StyleSheet, Linking, Share } from 'react-native';
import { isAndroid } from 'react-native-device-detection';
import { Surface, List, Button, Checkbox, Colors, withTheme } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';
import { BackButton, WoWsInfo, DividerPlus } from '../component';
import { LOCAL, SAVED, APP } from '../value/data';
import lang from '../value/lang';

class Settings extends Component {
  constructor(props) {
    super(props);

    this.state = {
      server_name: lang.server_name[DATA[LOCAL.userServer]],
      apiLanguage: DATA[LOCAL.apiLanguage].toUpperCase()
    };
  }

  render() {
    const { container, tint } = styles;
    const store = isAndroid ? APP.GooglePlay : APP.AppStore;
    return (
      <WoWsInfo about>
        <ScrollView>
          <List.Section title='API Settings'>
            <List.Accordion title={'Game Server - ' + this.state.server_name}>
              <View style={{flexDirection: 'row', justifyContent: 'space-around'}}>
                {lang.server_name.map((object, index) => 
                  <Button 
                    key = {object}
                    onPress={() => this.updateServer(index)}
                  >
                    {lang.server_name[index]}
                  </Button>
                )}
              </View>
            </List.Accordion>
            <List.Accordion title={'API Language - ' + this.state.apiLanguage}>
              <ScrollView horizontal
                contentContainerStyle={{flexDirection: 'row'}}>
                {Object.keys(DATA[SAVED.language]).map((language) => 
                  <Button 
                  key = {language}
                  onPress={() => this.updateApiLanguage(language)}
                  >
                    {language}
                  </Button>
                )}
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
        </ScrollView>
      </WoWsInfo>
    )
  };

  /**
   * Update app theme real time
   */
  updateTheme() {
  }

  /**
   * Update server that's being used
   */
  updateServer(index) {
    DATA[LOCAL.userServer] = index;
    this.setState({server_name: lang.server_name[DATA[LOCAL.userServer]]});    
  }

  /**
   * Update apiLanguage that's being used
   */
  updateApiLanguage(language) {
    DATA[LOCAL.apiLanguage] = language;
    this.setState({apiLanguage: DATA[LOCAL.apiLanguage].toUpperCase()});
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
