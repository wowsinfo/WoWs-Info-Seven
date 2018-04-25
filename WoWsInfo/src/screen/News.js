import React, { Component } from 'react'
import { View, Text, FlatList } from 'react-native';
import { WoWsLoading, NewsCell } from '../component';
import { NewsParser } from '../core';
import * as Animatable from 'react-native-animatable';

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
          side: 'left', to: 'open',
          animated: true
        });
      }
    }
  }

  async componentWillMount() {
    this.props.navigator.setOnNavigatorEvent(this.onNavigatorEvent.bind(this));
    await this.loadNews();
  }

  newsKey = (item) => {return item.title}        
  render() {
    const { isReady, data, isRefreshing } = this.state;
    if (isReady) {
      return (
        <Animatable.View animation='bounceInUp'>
          <FlatList data={data} keyExtractor={this.newsKey} onRefresh={() => this.refreshNews()}
          renderItem={({item}) => <NewsCell data={item}/>} refreshing={isRefreshing}/>
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