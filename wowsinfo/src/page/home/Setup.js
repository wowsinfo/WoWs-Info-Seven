/**
 * Setup.js
 * This page is for setuping API language and server
 * It only displays when you first launched WoWs Info
 */

import React, {Component} from 'react';
import {View, ScrollView, StyleSheet} from 'react-native';
import {
  Button,
  List,
  Paragraph,
  FAB,
  Text,
  Headline,
  Title,
  Subheading,
} from 'react-native-paper';
import {Actions} from 'react-native-router-flux';
import {lang} from '../../value/lang';
import {
  SERVER,
  getCurrServer,
  setCurrServer,
  setAPILanguage,
} from '../../value/data';
import {Downloader} from '../../core';
import {WoWsInfo, SectionTitle, LoadingIndicator} from '../../component';

class Setup extends Component {
  constructor(props) {
    super(props);

    this.state = {
      loading: true,
      error: false,
      server: SERVER,
      selected_server: 3,
      langList: [],
      langData: {},
      selected_lang: 'en',
    };

    let d = new Downloader(getCurrServer());
    d.getLanguage().then(data => {
      if (data) {
        const langList = data;
        const langData = [];

        for (const key in langList) langData.push(key);
        langData.sort();

        this.setState({langList: langList, langData: langData, loading: false});
      } else {
        // Issue getting language data, retry
        this.setState({error: true});
      }
    });
  }

  render() {
    const {loading, server, selected_server, langList, selected_lang, error} =
      this.state;
    const {fab, titleStyle, wrapView, scroll} = styles;
    return (
      <WoWsInfo hideAds empty>
        <ScrollView contentContainerStyle={scroll}>
          <SectionTitle title={lang.settings_api_settings} center bold />
          <Subheading style={titleStyle}>
            {`${lang.setting_game_server}: ${lang.server_name[selected_server]}`}
          </Subheading>
          <View style={wrapView}>
            {server.map((_, index) => (
              <Button onPress={() => this.updateServer(index)}>
                {lang.server_name[index]}
              </Button>
            ))}
          </View>
          {/* <FlatList data={server} renderItem={({index}) => {
              return <Button onPress={() => this.updateServer(index)}>{lang.server_name[index]}</Button>
            }} keyExtractor={i => i} numColumns={2}/> */}
          <Subheading style={titleStyle}>
            {`${lang.setting_api_language}: ${langList[selected_lang]}`}
          </Subheading>
          {this.renderAPILanguage()}
        </ScrollView>
        <FAB
          visible={!loading}
          icon="check"
          style={fab}
          label={lang.setup_done_button}
          onPress={loading ? null : () => this.finishSetup()}
        />
      </WoWsInfo>
    );
  }

  renderAPILanguage() {
    const {loading, error, langData, langList} = this.state;
    const {titleStyle, wrapView} = styles;

    if (loading) return <LoadingIndicator />;
    if (error)
      return (
        <View>
          <Paragraph style={titleStyle}>{lang.error_download_issue}</Paragraph>
          <List.Item
            title={lang.settings_app_send_feedback}
            description={lang.settings_app_send_feedback_subtitle}
            onPress={() => Linking.openURL(APP.Developer)}
          />
        </View>
      );

    return (
      <View style={wrapView}>
        {langData.map(item => (
          <Button onPress={() => this.updateApiLanguage(item)}>
            {langList[item]}
          </Button>
        ))}
      </View>
    );
  }

  updateServer(index) {
    setCurrServer(index);
    this.setState({selected_server: index});
  }

  updateApiLanguage(lang) {
    setAPILanguage(lang);
    this.setState({selected_lang: lang});
  }

  // Get selection and download data from api
  finishSetup() {
    Actions.reset('Menu');
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  scroll: {
    flexGrow: 1,
    alignItems: 'center',
    paddingTop: '15%',
  },
  top: {
    flex: 1,
  },
  fab: {
    position: 'absolute',
    bottom: 0,
    right: 0,
    left: 0,
    margin: 16,
  },
  titleStyle: {
    alignSelf: 'center',
    textAlign: 'center',
    marginTop: 16,
  },
  wrapView: {
    justifyContent: 'center',
    flexWrap: 'wrap',
    flexDirection: 'row',
  },
});

export {Setup};
