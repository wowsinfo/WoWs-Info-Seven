/**
 * Setup.js
 * This page is for setuping API language and server
 * It only displays when you first launched WoWs Info
 */

import React, { Component } from 'react';
import { FlatList, ScrollView, StyleSheet } from 'react-native';
import { Text, Button, Surface, Headline, List, RadioButton } from 'react-native-paper';
import { Actions } from 'react-native-router-flux';
import lang from '../../value/lang';
import { LOCAL, SERVER, getCurrServer } from '../../value/data';
import { SafeStorage, Downloader } from '../../core';
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
    return (
      <WoWsInfo title={lang.setup_done_button} 
        noRight noLeft onPress={() => this.finishSetup()}>
        <ScrollView>
          <SectionTitle title={lang.settings_api_settings}/>
          <List.Section title={`Game server: ${lang.server_name[selected_server]}`}>
            <FlatList data={server} renderItem={({index}) => {
              return <Button onPress={() => this.updateServer(index)}>{lang.server_name[index]}</Button>
            }} keyExtractor={i => i} numColumns={2}/>
          </List.Section>
          { loading ? null : 
          <List.Section title={`API language: ${langList[selected_lang]}`}>
            <FlatList data={langData} renderItem={({item}) => {
              return <Button onPress={() => this.updateApiLanguage(item)}>{langList[item]}</Button>
            }} keyExtractor={i => i} numColumns={2}/>
          </List.Section> }
        </ScrollView>
      </WoWsInfo>
    )
  };

  // Get selection and download data from api
  finishSetup() {
    
    // Download data
    
    DATA[LOCAL.firstLaunch] = false;
    SafeStorage.set(LOCAL.firstLaunch, false);
    Actions.reset('Home');
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  top: {
    flex: 1
  }
});

export { Setup };
