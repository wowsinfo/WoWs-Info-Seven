import React, { Component } from 'react'
import { View, Text, FlatList, DrawerLayoutAndroid } from 'react-native';
import { WoWsLoading, NewsCell, DrawerCell } from '../component';
import { NewsParser } from '../core';
import * as Animatable from 'react-native-animatable';
import Drawer from './Drawer';
import { navStyle } from '../constant/colour';
import language from '../constant/language';

export default class News extends Component {
  state = {
    isReady: false,
    data: [],
    isRefreshing: false
  }

  onNavigatorEvent(event) {
    if (event.type == 'NavBarButtonPress') {
      if (event.id == 'drawer') {
        this.props.navigator.toggleDrawer({
          side: 'left',
          animated: true
        });
      } else if (event.id == 'search') {
        this.props.navigator.push({
          title: language.search_title,
          screen: 'info.search',
          navigatorStyle: navStyle()
        })
      }
    }
  }

  async componentWillMount() {
    this.props.navigator.setOnNavigatorEvent(this.onNavigatorEvent.bind(this));
    await this.loadNews();
  }

  newsKey = (item) => {return item.title}        
  render() {
    const { data, isRefreshing, isReady } = this.state;
    if (isReady) {
      return (
        <Animatable.View animation='bounceInUp'>
          <FlatList data={data} keyExtractor={this.newsKey} onRefresh={() => this.refreshNews()}
          renderItem={({item}) => <NewsCell data={item}/>} refreshing={isRefreshing} showsVerticalScrollIndicator={false}/>
        </Animatable.View>
      )
    } else return <WoWsLoading />
  }

  /**
   * Loading news from server
   */
  async loadNews() {
    let news = new NewsParser(server, api_language);
    let data = await news.getNews();
    this.setState({
      isReady: true,
      data: data,
      isRefreshing: false,
    })
  }

  /**
   * Refreshing news from server (load again)
   */
  async refreshNews() {
    // Get news again
    this.setState({ isRefreshing: true })
    await this.loadNews();
  }
}