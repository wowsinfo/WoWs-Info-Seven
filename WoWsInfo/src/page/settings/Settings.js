import React, { Component } from 'react';
import { View, ScrollView, FlatList, StyleSheet, Linking, Share } from 'react-native';
import { isAndroid } from 'react-native-device-detection';
import { Surface, List, Button, Checkbox, Colors, withTheme, Portal, Dialog, Text } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';
import { WoWsInfo, DividerPlus, Touchable } from '../../component';
import { APP, LOCAL, SAVED } from '../../value/data';
import { TintColour, UpdateTintColour, UpdateDarkMode } from '../../value/colour';
import { SafeStorage } from '../../core';
import { BLUE, RED, GREEN, PINK, PURPLE, DEEPPRUPLE, INDIGO, LIGHTBLUE, CYAN, TEAL, LIGHTGREEN, LIME, YELLOW, AMBER, ORANGE, DEEPORANGE, BROWN, GREY, BLUEGREY } from 'react-native-material-color';

class Settings extends Component {
  constructor(props) {
    super(props);

    this.state = {
      darkMode: DARKMODE,
      tintColour: TintColour(),
      showColour: false,
    };
    
    this.colourList = [RED, PINK, PURPLE, DEEPPRUPLE, INDIGO, BLUE, LIGHTBLUE, CYAN, TEAL, GREEN, LIGHTGREEN, LIME, 
      YELLOW, AMBER, ORANGE, DEEPORANGE, BROWN, GREY, BLUEGREY];
  }

  componentWillUnmount() {
    Actions.refresh();
  }

  render() {
    const { container, tint } = styles;
    const { darkMode, showColour, tintColour } = this.state;
    const store = isAndroid ? APP.GooglePlay : APP.AppStore;
    return (
      <WoWsInfo about noLeft>
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
            <List.Item title='Dark Theme' onPress={() => this.updateTheme()} />
            <List.Item title='Tint Colour' onPress={() => this.setState({showColour: true})}
              right={() => <View style={[tint, {backgroundColor: tintColour[500]}]}/>}/>              
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
        <Portal>
          <Dialog visible={showColour} dismissable={true} theme={{roundness: 16}}
            style={{maxHeight: '61.8%'}} onDismiss={() => this.setState({showColour: false})}>
            <FlatList bounces={false} data={this.colourList} keyExtractor={(item, index) => String(index)}
              showsVerticalScrollIndicator={false} renderItem={({item}) => {
                return <Touchable style={{backgroundColor: item[500], height: 64}}
                  onPress={() => this.updateTint(item)} />
              }} />
          </Dialog>
        </Portal>
      </WoWsInfo>
    )
  };

  /**
   * Update app theme real time
   */
  updateTheme() {
    // Switch mode
    UpdateDarkMode();
    this.setState({darkMode: DARKMODE});
    this.props.theme.dark = DARKMODE;
    this.props.theme.colors = DARKMODE ? DARK.colors : LIGHT.colors;
  }

  /**
   * UPdate app tint colour
   * @param {*} tint 
   */
  updateTint(tint) {
    UpdateTintColour(tint);
    
    DARK.colors.primary = tint[500];
    DARK.colors.accent = tint[500];
    LIGHT.colors.accent = tint[500];
    LIGHT.colors.primary = tint[500];
    
    this.props.theme.colors = DARK.colors;

    this.setState({showColour: false, tintColour: tint});
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
