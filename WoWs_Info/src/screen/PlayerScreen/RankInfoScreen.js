import React from 'react';
import { WoWsLoading, RankCell } from '../../component';
import GridView from 'react-native-super-grid';
import { RankInfo } from '../../core';

class RankInfoScreen extends React.PureComponent {
  state = {
    isReady: false,
    rank: [],
    ship: {},
  }

  async componentWillMount() {
    const { id, playerName } = this.props;
    let rank = new RankInfo(id, global.server);
    let rankInfo = await rank.getRankInfo();
    let shipInfo = await rank.getRankShipInfo();
    this.setState({
      isReady: true,
      rank: rankInfo,
      ship: shipInfo,
    })
  }

  render() {
    const { isReady, rank, ship } = this.state;
    if (isReady) {
      return (
        <GridView itemDimension={300} items={rank} renderHeader={this.renderHeader} enableEmptySections
          contentInset={{bottom: 50}} renderItem={item => <RankCell rank={item} ship={ship}/>} />
      )
    } else return <WoWsLoading />
  }
}

export {RankInfoScreen};