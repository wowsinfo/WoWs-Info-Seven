import React, { Component } from 'react';
import { View, ScrollView, FlatList, StyleSheet, Linking, Share } from 'react-native';
import { isAndroid, isIos } from 'react-native-device-detection';
import { Surface, List, Button, Checkbox, Colors, withTheme, Portal, Dialog, Text } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';
import { WoWsInfo, DividerPlus, Touchable } from '../../component';
import { APP, LOCAL, SAVED, getCurrServer, getAPILanguage } from '../../value/data';
import { TintColour, UpdateTintColour, UpdateDarkMode } from '../../value/colour';
import { SafeStorage } from '../../core';
import { BLUE, RED, GREEN, PINK, PURPLE, DEEPPRUPLE, INDIGO, LIGHTBLUE, CYAN, TEAL, LIGHTGREEN, LIME, YELLOW, AMBER, ORANGE, DEEPORANGE, BROWN, GREY, BLUEGREY } from 'react-native-material-color';
import lang from '../../value/lang';

class Settings extends Component {
  constructor(props) {
    super(props);

    this.state = {
      darkMode: DARKMODE,
      tintColour: TintColour(),
      showColour: false,
      server: getCurrServer(),
      APILanguage: getAPILanguage(),
    };
    
    this.colourList = [RED, PINK, PURPLE, DEEPPRUPLE, INDIGO, BLUE, LIGHTBLUE, CYAN, TEAL, GREEN, LIGHTGREEN, LIME, 
      YELLOW, AMBER, ORANGE, DEEPORANGE, BROWN, GREY, BLUEGREY];
    this.store = isAndroid ? APP.GooglePlay : APP.AppStore;
  }

  componentWillUnmount() {
    Actions.refresh();
  }

  render() {
    const { container, tint } = styles;
    const { darkMode, showColour, tintColour, server, APILanguage } = this.state;
    return (
      <WoWsInfo about noLeft>
        <ScrollView>
          { this.renderAPISettings() }
          { this.renderAppSettings() }
          { this.renderWoWsInfo() }
          { this.renderOpenSource() }
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

  renderAPISettings() {
    const { darkMode, showColour, tintColour, server, APILanguage } = this.state;
    return (
      <List.Section title={lang.settings_api_settings}>
            <List.Accordion title={`Game server: ${lang.server_name[server]}`}>
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
            <List.Accordion title={`API language: ${APILanguage}`}>
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
    )
  }

  renderAppSettings() {
    const { darkMode, showColour, tintColour, server, APILanguage } = this.state;
    const { container, tint } = styles;

    return (
      <List.Section title={lang.settings_app_settings}>
            <List.Item title={lang.settings_app_dark_mode} onPress={() => this.updateTheme()} />
            <List.Item title={lang.settings_app_theme_colour} onPress={() => this.setState({showColour: true})}
              right={() => <View style={[tint, {backgroundColor: tintColour[500]}]}/>}/>              
            <List.Item title={lang.settings_app_swap_buttons}/>
            <List.Item title={lang.settings_app_clean_mode}/>
          </List.Section>
    )
  }

  renderWoWsInfo() {
    const { darkMode, showColour, tintColour, server, APILanguage } = this.state;

    return (
      <List.Section title={lang.app_name} style={{color: TintColour()[500]}}>
            <List.Item title={lang.settings_app_send_feedback}
              onPress={() => Linking.openURL(APP.Developer)}/>
            <List.Item title={lang.settings_app_report_issues}
              onPress={() => Linking.openURL(`${APP.Github}/issues`)}/>
            <List.Item title={lang.settings_app_write_review}
              onPress={() => Linking.openURL(this.store)}/>
            <List.Item title={lang.settings_app_share} onPress={this.shareApp}/>
          </List.Section>
    )
  }

  renderOpenSource() {
    const { darkMode, showColour, tintColour, server, APILanguage } = this.state;

    return (
      <List.Section title={lang.settings_open_source}>
            <List.Item title={lang.settings_open_source_github}
              onPress={() => Linking.openURL(APP.Github)}/>
            <List.Item title={lang.settings_open_source_licence} />
          </List.Section>
    )
  }

  shareApp = () => {
    if (isIos) {
      Share.share({url: this.store});
    } else {
      Share.share({message: `${lang.app_name}\n${this.store}`});
    }
  }

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
