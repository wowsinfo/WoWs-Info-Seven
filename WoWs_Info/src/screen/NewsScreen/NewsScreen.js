import React from 'react';
import { NewsParser } from '../../core';
import { NewsCell, WoWsLoading } from '../../component';
import { View, FlatList } from 'react-native';

class NewsScreen extends React.PureComponent {
  state = {
    isReady,
    data: [],
  }
  async componentWillMount() {
    let news = new NewsParser(global.server, global.newsLanguage);
    await news.getNews();
  }

  render() {
    if (this.state.isReady) {
      return (
        <View>
          <FlatList />
        </View>
      )
    } return <WoWsLoading />;
  }
}

export {NewsScreen}