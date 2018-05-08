import React, { Component } from 'react';
import { View } from 'react-native-animatable';
import GridView from 'react-native-super-grid';
import { NoInformation, WoWsLoading, RankCell } from '../../component';
import { RankInfo } from '../../core';
import { navStyle } from '../../constant/colour';
import language from '../../constant/language';

class Rank extends Component {
  state = {
    isReady: false, rank: [], ship: {}
  }

  async componentWillMount() {
    const { id, playerName, server } = this.props;
    let rank = new RankInfo(id, server);
    let rankInfo = await rank.getRankInfo();
    let shipInfo = await rank.getRankShipInfo();
    console.log(rankInfo, shipInfo);
    this.setState({
      isReady: true, rank: rankInfo, ship: shipInfo
    })
  }

  render() {
    const { isReady, rank, ship } = this.state;
    if (isReady) {
      if (rank) {
        return (
          <View animation='fadeInUp'>
            <GridView itemDimension={300} items={rank} contentInset={{bottom: 50}}
              renderItem={item => <RankCell detail={this.pushToShip} rank={item} ship={ship}/>}/>
          </View>
        )
      } else return <NoInformation />
    } else return <WoWsLoading />
  }

  pushToShip = (item) => {
    console.log(item)
    this.props.navigator.push({
      screen: 'rank.ship',
      title: language.rank_season + item.season,
      navigatorStyle: navStyle(),
      passProps: {rank: item}
    })
  }
}

export { Rank };