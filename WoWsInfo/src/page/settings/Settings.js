import React, { Component } from 'react';
import { View, ScrollView, FlatList, StyleSheet, Linking, Share } from 'react-native';
import { isAndroid, isIos } from 'react-native-device-detection';
import { Surface, List, Button, Checkbox, Colors, withTheme, Portal, Dialog, Text } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';
import { WoWsInfo, DividerPlus, Touchable, SectionTitle } from '../../component';
import { APP, LOCAL, SAVED, getCurrServer, getAPILanguage, getAPILangName, SERVER, getAPIList, setCurrServer, setAPILanguage, setSwapButton, getSwapButton } from '../../value/data';
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
      swapButton: getSwapButton(),
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
    const { server, APILanguage } = this.state;
    const langList = getAPIList();
    const langData = [];
    for (let key in langList) langData.push(key);
    langData.sort();

    return (
      <Surface>
        <SectionTitle title={lang.settings_api_settings}/>
        <List.Section title={`Game server: ${lang.server_name[server]}`}>
          <FlatList data={SERVER} renderItem={({index}) => {
            return <Button onPress={() => this.updateServer(index)}>{lang.server_name[index]}</Button>
          }} keyExtractor={i => i} numColumns={2}/>
        </List.Section>
        <List.Section title={`API language: ${langList[APILanguage]}`}>
          <FlatList data={langData} renderItem={({item}) => {
            return <Button onPress={() => this.updateApiLanguage(item)}>{langList[item]}</Button>
          }} keyExtractor={i => i} numColumns={2}/>
        </List.Section>
      </Surface>
    )
  }

  renderAppSettings() {
    const { tintColour, swapButton, darkMode } = this.state;
    const { tint } = styles;

    return (
      <Surface>
        <SectionTitle title={lang.settings_app_settings}/>
        <List.Item title={lang.settings_app_dark_mode} onPress={() => this.updateTheme()} 
          right={() => <Checkbox status={darkMode ? 'checked' : 'unchecked'}/>}/>
        <List.Item title={lang.settings_app_theme_colour} onPress={() => this.setState({showColour: true})}
          right={() => <View style={[tint, {backgroundColor: tintColour[500]}]}/>}/>              
        <List.Item title={lang.settings_app_swap_buttons} onPress={() => this.swapButton(!swapButton)}
          right={() => <Checkbox status={swapButton ? 'checked' : 'unchecked'}/>}/>
      </Surface>
    )
  }

  renderWoWsInfo() {
    let issueLink = `${APP.Github}/issues`;

    return (
      <Surface>
        <SectionTitle title={lang.app_name}/>
        <List.Item title={lang.settings_app_send_feedback} 
          description={lang.settings_app_send_feedback_subtitle}
          onPress={() => Linking.openURL(APP.Developer)}/>
        <List.Item title={lang.settings_app_report_issues} description={issueLink}
          onPress={() => Linking.openURL(issueLink)}/>
        <List.Item title={lang.settings_app_write_review}
          onPress={() => Linking.openURL(this.store)} description={this.store}/>
        <List.Item title={lang.settings_app_share} onPress={this.shareApp}
          description={lang.settings_app_share_subtitle}/>
      </Surface>
    )
  }

  renderOpenSource() {
    return (
      <Surface>
        <SectionTitle title={lang.settings_open_source}/>
        <List.Item title={lang.settings_open_source_github}
          description={APP.Github} onPress={() => Linking.openURL(APP.Github)}/>
        <List.Item title={lang.settings_open_source_licence}
          description={lang.settings_open_source_licence_subtitle}/>
      </Surface>
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
   * Swap bottom buttons
   */
  swapButton(curr) {
    setSwapButton(curr);
    this.setState({swapButton: getSwapButton()});
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
    setCurrServer(index);
    this.setState({server: index});    
  }

  /**
   * Update apiLanguage that's being used
   */
  updateApiLanguage(language) {
    setAPILanguage(language);
    this.setState({APILanguage: language});
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
