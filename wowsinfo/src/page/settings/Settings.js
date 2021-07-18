import React, {Component} from 'react';
import {
  View,
  ScrollView,
  FlatList,
  StyleSheet,
  Linking,
  Share,
  Alert,
} from 'react-native';
import {isAndroid, isIos} from 'react-native-device-detection';
import {
  List,
  Button,
  Checkbox,
  withTheme,
  Portal,
  Dialog,
  DarkTheme,
  DefaultTheme,
} from 'react-native-paper';
import {Actions} from 'react-native-router-flux';
import {WoWsInfo, Touchable, SectionTitle} from '../../component';
import {
  APP,
  getCurrServer,
  getAPILanguage,
  SERVER,
  getAPIList,
  setCurrServer,
  setAPILanguage,
  setSwapButton,
  getSwapButton,
  getUserLang,
  setUserLang,
  setImageMode,
  setFirstLaunch,
} from '../../value/data';
import {TintColour, UpdateTintColour, UpdateDarkMode} from '../../value/colour';
import {SafeAction, SafeFetch, Guard} from '../../core';
import {
  BLUE,
  RED,
  GREEN,
  PINK,
  PURPLE,
  DEEPPRUPLE,
  INDIGO,
  LIGHTBLUE,
  CYAN,
  TEAL,
  LIGHTGREEN,
  LIME,
  YELLOW,
  AMBER,
  ORANGE,
  DEEPORANGE,
  BROWN,
  GREY,
  BLUEGREY,
} from 'react-native-material-color';
import {lang} from '../../value/lang';
import {WikiAPI} from '../../value/api';

class Settings extends Component {
  constructor(props) {
    super(props);

    this.state = {
      darkMode: DARKMODE,
      tintColour: TintColour(),
      showColour: false,
      server: getCurrServer(),
      APILanguage: getAPILanguage(),
      userLanguage: getUserLang(),
      swapButton: getSwapButton(),
      noImageMode: NOIMAGEMODE,
    };

    this.colourList = [
      RED,
      PINK,
      PURPLE,
      DEEPPRUPLE,
      INDIGO,
      BLUE,
      LIGHTBLUE,
      CYAN,
      TEAL,
      GREEN,
      LIGHTGREEN,
      LIME,
      YELLOW,
      AMBER,
      DEEPORANGE,
      BROWN,
      GREY,
      BLUEGREY,
    ];
  }

  componentWillUnmount() {
    setTimeout(() => Actions.refresh(), 300);
  }

  render() {
    const {showColour} = this.state;
    return (
      <WoWsInfo about>
        <ScrollView showsVerticalScrollIndicator={false}>
          {this.renderAPISettings()}
          {this.renderAppSettings()}
          {this.renderWoWsInfo()}
          {this.renderOpenSource()}
        </ScrollView>
        <Portal>
          <Dialog
            visible={showColour}
            dismissable={true}
            theme={{roundness: 16}}
            style={{maxHeight: '61.8%'}}
            onDismiss={() => this.setState({showColour: false})}>
            <FlatList
              bounces={false}
              data={this.colourList}
              keyExtractor={(item, index) => String(index)}
              showsVerticalScrollIndicator={false}
              renderItem={({item}) => {
                return (
                  <Touchable
                    style={{backgroundColor: item[500], height: 64}}
                    onPress={() => this.updateTint(item)}
                  />
                );
              }}
            />
          </Dialog>
        </Portal>
      </WoWsInfo>
    );
  }

  renderAPISettings() {
    const {server, APILanguage, userLanguage} = this.state;

    const langList = getAPIList();
    const appLang = {
      en: 'English',
      ja: '日本語',
      id: 'Bahasa Indonesia',
      zh: '简体中文',
      'zh-hant': '繁体中文',
    };
    let appLangList = [];
    for (let code in appLang)
      appLangList.push({code: code, lang: appLang[code]});

    let display = appLang[userLanguage];
    if (display == null) display = '???';

    return (
      <View>
        <SectionTitle title={lang.settings_api_settings} />
        <List.Section
          title={`${lang.setting_game_server} - ${lang.server_name[server]}`}>
          <View style={{flexDirection: 'row', flexWrap: 'wrap'}}>
            {SERVER.map((_, index) => (
              <Button onPress={() => this.updateServer(index)}>
                {lang.server_name[index]}
              </Button>
            ))}
          </View>
          {/* <FlatList data={SERVER} renderItem={({index}) => {
            return <Button onPress={() => this.updateServer(index)}>{lang.server_name[index]}</Button>
          }} keyExtractor={i => i} numColumns={2}/> */}
        </List.Section>
        <List.Section
          title={`${lang.setting_api_language} - ${langList[APILanguage]}`}>
          {CANUPDATEAPI ? this.renderAPILanguage(langList) : null}
        </List.Section>
        <List.Section title={`${lang.setting_app_language} - ${display}`}>
          <View style={{flexDirection: 'row', flexWrap: 'wrap'}}>
            {appLangList.map(item => (
              <Button onPress={() => this.updateUserLang(item.code)}>
                {item.lang}
              </Button>
            ))}
          </View>
          {/* <FlatList data={appLangList} renderItem={({item}) => {
            return <Button onPress={() => this.updateUserLang(item.code)}>{item.lang}</Button>
          }} keyExtractor={i => i.code} numColumns={3} style={{flexWrap: 'wrap'}}/> */}
        </List.Section>
      </View>
    );
  }

  renderAPILanguage(langList) {
    const langData = [];
    for (let key in langList) langData.push(key);
    langData.sort();

    return (
      <View>
        <View style={{flexDirection: 'row', flexWrap: 'wrap'}}>
          {langData.map(item => (
            <Button onPress={() => this.updateApiLanguage(item)}>
              {langList[item]}
            </Button>
          ))}
        </View>
        {/* <FlatList data={langData} renderItem={({item}) => {
            return <Button onPress={() => this.updateApiLanguage(item)}>{langList[item]}</Button>
          }} keyExtractor={i => i} horizontal/> */}
        <Button
          mode="contained"
          theme={{roundness: 0}}
          onPress={() => {
            Alert.alert(lang.app_name, lang.setting_api_update_data_title, [
              {
                text: lang.setting_api_update_data_update,
                onPress: () =>
                  this.updateApiLanguage(this.state.APILanguage, true),
                style: 'destructive',
              },
              {text: lang.setting_api_update_data_cancel, onPress: () => null},
            ]);
          }}>
          {lang.setting_api_update_data}
        </Button>
      </View>
    );
  }

  renderAppSettings() {
    const {tintColour, swapButton, darkMode, noImageMode} = this.state;
    const {tint} = styles;

    return (
      <View>
        <SectionTitle title={lang.settings_app_settings} />
        <List.Item
          title={lang.settings_app_dark_mode}
          onPress={() => this.updateTheme()}
          right={() => <Checkbox status={darkMode ? 'checked' : 'unchecked'} />}
        />
        <List.Item
          title={lang.settings_app_theme_colour}
          onPress={() => this.setState({showColour: true})}
          right={() => (
            <View style={[tint, {backgroundColor: tintColour[500]}]} />
          )}
        />
        <List.Item
          title={lang.settings_app_no_image_mode}
          onPress={() => this.noImage(!noImageMode)}
          right={() => (
            <Checkbox status={noImageMode ? 'checked' : 'unchecked'} />
          )}
        />
        <List.Item
          title={lang.settings_app_swap_buttons}
          onPress={() => this.swapButton(!swapButton)}
          right={() => (
            <Checkbox status={swapButton ? 'checked' : 'unchecked'} />
          )}
        />
      </View>
    );
  }

  renderWoWsInfo() {
    let issueLink = `${APP.Github}/issues/new`;

    return (
      <View>
        <SectionTitle title={lang.app_name} />
        <List.Item
          title={lang.settings_app_send_feedback}
          description={lang.settings_app_send_feedback_subtitle}
          onPress={() => Linking.openURL(APP.Developer)}
        />
        <List.Item
          title={lang.settings_app_report_issues}
          description={issueLink}
          onPress={() => Linking.openURL(issueLink)}
        />
        {isAndroid ? (
          <List.Item
            title={lang.settings_app_check_for_update}
            onPress={this.checkAppUpdate}
            description={`v${APP.Version}`}
          />
        ) : null}
      </View>
    );
  }

  renderOpenSource() {
    return (
      <View>
        <SectionTitle title={lang.settings_open_source} />
        <List.Item
          title={lang.settings_open_source_github}
          description={APP.Github}
          onPress={() => Linking.openURL(APP.Github)}
        />
        <List.Item
          title={lang.settings_open_source_licence}
          description={lang.settings_open_source_licence_subtitle}
          onPress={() => SafeAction('License')}
        />
      </View>
    );
  }

  checkAppUpdate = () => {
    if (CANCHECKFORUPDATE) {
      CANCHECKFORUPDATE = false;
      SafeFetch.normal(WikiAPI.Github_AppVersion).then(v => {
        let version = Guard(v, 'version', null);
        if (version != null) {
          if (version > APP.Version) {
            this.displayUpdate(true, version);
          } else {
            this.displayUpdate(false);
          }
        }
      });
    } else {
      this.displayUpdate(false);
    }
  };

  displayUpdate(result, version = null) {
    if (result) {
      const format = require('string-format');
      Alert.alert(
        lang.app_name,
        format(lang.settings_app_has_update, version),
        [
          {text: 'Google Play', onPress: () => Linking.openURL(APP.GooglePlay)},
          {text: 'Github', onPress: () => Linking.openURL(APP.LatestRelease)},
        ],
      );
    } else {
      Alert.alert(lang.app_name, lang.settings_app_no_update);
    }
  }

  /**
   * Swap bottom buttons
   */
  swapButton(curr) {
    setSwapButton(curr);
    this.setState({swapButton: getSwapButton()});
  }

  noImage(curr) {
    setImageMode(curr);
    this.setState({noImageMode: NOIMAGEMODE});
  }

  /**
   * Update app theme real time
   */
  updateTheme() {
    const {tintColour} = this.state;
    // Switch mode
    UpdateDarkMode();
    this.setState({darkMode: DARKMODE});
    this.props.theme.dark = DARKMODE;
    if (DARKMODE) {
      global.DARK = {
        colors: {
          ...DarkTheme.colors,
          View: 'black',
          text: GREY[50],
          primary: tintColour[500],
          accent: tintColour[300],
        },
      };
      this.props.theme.colors = DARK.colors;
    } else {
      // Setup global light theme
      global.LIGHT = {
        colors: {
          ...DefaultTheme.colors,
          View: 'white',
          text: GREY[900],
          primary: tintColour[500],
          accent: tintColour[300],
        },
      };
      this.props.theme.colors = LIGHT.colors;
    }
    console.log(this.props.theme);
  }

  /**
   * UPdate app tint colour
   * @param {*} tint
   */
  updateTint(tint) {
    UpdateTintColour(tint);

    this.props.theme.colors.primary = tint[500];
    this.props.theme.colors.accent = tint[300];

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
   * @param {String} language
   * @param {Boolean} force foce update
   */
  updateApiLanguage(language, force) {
    if (!force && language === this.state.APILanguage) return;

    setAPILanguage(language);
    this.setState({APILanguage: language});

    setFirstLaunch(true);
    CANUPDATEAPI = false;
    Actions.reset('Menu');
  }

  updateUserLang(code) {
    setUserLang(code);
    lang.setLanguage(code);
    this.setState({userLanguage: code});
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  bottom: {
    position: 'absolute',
    left: 0,
    right: 0,
    bottom: 0,
  },
  tint: {
    height: 36,
    width: 36,
    borderRadius: 18,
  },
});

export default withTheme(Settings);
