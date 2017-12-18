import React from 'react';
import { NewsParser } from '../../core';
import { NewsCell, WoWsLoading } from '../../component';
import { View, FlatList } from 'react-native';

class NewsScreen extends React.PureComponent {
  state = {
    isReady: false,
    data: [],
    isRefreshing: false,
    language: global.newsLanguage,
  }

  keyExtractor = (item) => {return item.title}  
  async componentWillMount() {
    await this.loadNews();
  }

  render() {
    if (this.state.isReady) {
      return (
        <View style={{flex: 1}}>
          <FlatList data={this.state.data} keyExtractor={this.keyExtractor} onRefresh={() => this.refreshNews()}
            renderItem={({item}) => <NewsCell data={item}/>} refreshing={this.state.isRefreshing}/>
        </View>
      )
    } return <WoWsLoading />;
  }

  async loadNews() {
    let news = new NewsParser(global.server, global.newsLanguage);
    let data = await news.getNews();
    this.setState({
      isReady: true,
      data: data,
      isRefreshing: false,
    })
  }

  async refreshNews() {
    console.log(global.newsLanguage, this.state.language);
    if (global.newsLanguage == this.state.language) return;
    else {
      // Get news in another language
      this.setState({
        isRefreshing: true,
      })
      await this.loadNews();
    }
  }
}

export {NewsScreen}