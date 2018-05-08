import React, { Component } from 'react';
import GridView from 'react-native-super-grid';
import { ShipInfoCell } from '../../component';

class RankDetail extends Component {
  render() {
    const { ship } = this.props;
    let sorted = ship.sort(function(a, b) { return b.index - a.index })
    return (
      <GridView itemDimension={300} items={ship} renderHeader={this.renderHeader} enableEmptySections
        automaticallyAdjustContentInsets={false} renderFooter={this.renderFooter} renderItem={item => <ShipInfoCell info={item}/>}/>
    )
  }
}

export { RankDetail };