import React from 'react';
import { NewsParser } from '../../core';
import { NewsCell, WoWsLoading } from '../../component';
import { View, FlatList } from 'react-native';

class NewsScreen extends React.PureComponent {
  state = {
    isReady: false,
    data: [],
  }

  keyExtractor = (item) => {return item.title}  
  async componentWillMount() {
    let news = new NewsParser(global.server, global.newsLanguage);
    let data = await news.getNews();
    this.setState({
      isReady: true,
      data: data,
    })
  }

  render() {
    if (this.state.isReady) {
      return (
        <View>
          <FlatList data={this.state.data} keyExtractor={this.keyExtractor} renderItem={({item}) => 
            <NewsCell data={item}/>
          } />
        </View>
      )
    } return <WoWsLoading />;
  }
}

export {NewsScreen}