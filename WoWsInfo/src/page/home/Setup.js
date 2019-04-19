/**
 * Setup.js
 * This page is for setuping API language and server
 * It only displays when you first launched WoWs Info
 */

import React, { Component } from 'react';
import { FlatList, ScrollView, StyleSheet } from 'react-native';
import { Button, List, Paragraph, FAB } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';
import { lang } from '../../value/lang';
import { SERVER, getCurrServer, setCurrServer, setAPILanguage } from '../../value/data';
import { Downloader } from '../../core';
import { WoWsInfo, SectionTitle } from '../../component';

class Setup extends Component {
  constructor(props) {
    super(props);

    this.state = {
      loading: true,
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
      }
    });
  }

  render() {
    const { loading, server, selected_server, langList, langData, selected_lang } = this.state;
    const { fab } = styles;
    return (
      <WoWsInfo hideAds empty>
        <ScrollView>
          <SectionTitle title={lang.settings_api_settings}/>
          <List.Section title={`${lang.setting_game_server}: ${lang.server_name[selected_server]}`}>
            <FlatList data={server} renderItem={({index}) => {
              return <Button onPress={() => this.updateServer(index)}>{lang.server_name[index]}</Button>
            }} keyExtractor={i => i} numColumns={2}/>
          </List.Section>
          <List.Section title={`${lang.setting_api_language}: ${langList[selected_lang]}`}>
            { loading ? <Paragraph style={{margin: 16}}>{lang.error_download_issue}</Paragraph> : 
              <FlatList data={langData} renderItem={({item}) => {
                return <Button onPress={() => this.updateApiLanguage(item)}>{langList[item]}</Button>
            }} keyExtractor={i => i} numColumns={2}/> }
          </List.Section>
        </ScrollView>
        <FAB visible={!loading} icon='done' style={fab} onPress={loading ? null : () => this.finishSetup()}/>
      </WoWsInfo>
    )
  };

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
  top: {
    flex: 1
  },
  fab: {
    position: 'absolute',
    bottom: 0,
    right: 0,
    margin: 16
  }
});

export { Setup };
