import React, { Component } from 'react'
import { View, Text, FlatList, DrawerLayoutAndroid } from 'react-native';
import { WoWsLoading, NewsCell, DrawerCell } from '../component';
import { NewsParser } from '../core';
import * as Animatable from 'react-native-animatable';
import Drawer from './Drawer';
import { navStyle } from '../constant/colour';

export default class News extends Component {
  state = {
    isReady: false,
    data: [],
    isRefreshing: false
  }

  onNavigatorEvent(event) {
    if (event.type == 'NavBarButtonPress') {
      if (event.id == 'drawer') {
        this.refs['drawer'].openDrawer();
      } else if (event.id == 'search') {
        this.props.navigator.push({
          title: 'Search',
          screen: 'info.Settings',
          navigatorStyle: navStyle()
        })
      }
    }
  }

  async componentWillMount() {
    this.props.navigator.setOnNavigatorEvent(this.onNavigatorEvent.bind(this));
    this.props.navigator.push({
      scr
    })
    await this.loadNews();
  }

  newsKey = (item) => {return item.title}        
  render() {
    if (this.state.isReady) {
      if (android) {
        return (
          <DrawerLayoutAndroid drawerWidth={300} ref='drawer'
            drawerPosition={DrawerLayoutAndroid.positions.Left}
            renderNavigationView={() => Drawer}>
            { this.renderNews() }
          </DrawerLayoutAndroid>
        )
      } else return this.renderNews;
    } else return <WoWsLoading />
  }

  /**
   * Render news list
   */
  renderNews = () => {
    const { data, isRefreshing } = this.state;        
    return (
      <Animatable.View animation='bounceInUp'>
        <FlatList data={data} keyExtractor={this.newsKey} onRefresh={() => this.refreshNews()}
        renderItem={({item}) => <NewsCell data={item}/>} refreshing={isRefreshing}/>
      </Animatable.View>
    )
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