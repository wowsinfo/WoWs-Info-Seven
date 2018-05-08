import React, { Component } from 'react';
import { View } from 'react-native-animatable';
import GridView from 'react-native-super-grid';
import { NoInformation, WoWsLoading } from '../../component';

class Rank extends Component {
  state = {
    isReady: false, rank: [], ship: {}
  }

  async componentWillMount() {
    const { id, playerName, server } = this.props;
    let rank = new RankInfo(id, server);
    let rankInfo = await rank.getRankInfo();
    let shipInfo = await rank.getRankShipInfo();
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
              renderItem={item => <RankCell rank={item} ship={ship}/>}/>
          </View>
        )
      } else return <NoInformation />
    } else return <WoWsLoading />
  }
}

export { Rank };