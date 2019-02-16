import React, { PureComponent } from 'react';
import { View, Image, StyleSheet } from 'react-native';
import { WoWsInfo, WarshipCell, Touchable, RatingButton, FooterPlus, SimpleRating } from '../../component';
import { getOverallRating, roundTo, getComment, getColourList, getColour, SafeAction, filterShip } from '../../core';
import { FlatGrid } from 'react-native-super-grid';
import { SAVED } from '../../value/data';
import { lang } from '../../value/lang';

class PlayerShip extends PureComponent {
  constructor(props) {
    super(props);

    let ships = props.data;
    let rating = props.rating;
    if (rating == null) {
      // Prevent unnessary
      rating = getOverallRating(ships);
    }
    console.log(ships);

    this.original = ships.sort((a, b) => b.ap - a.ap);
    this.state = {
      data: this.original,
      rating: rating,
      filter: {}
    };
  }

  componentDidUpdate() {
    const { filter } = this.props;
    if (filter) {
      // Prevent repetitive update
      if (filter === this.state.filter) return;
      this.setState({filter: filter});
      this.updateShip(filter);
    }
  }

  render() {
    const { data, rating } = this.state;
    console.log(data);
    return (
      <WoWsInfo title={`${lang.wiki_warship_footer} - ${data.length}`} onPress={() => SafeAction('WarshipFilter', {applyFunc: this.updateShip})}>
        <FlatGrid itemDimension={150} items={data} renderItem={({item}) => this.renderShip(item)} 
          showsVerticalScrollIndicator={false} fixed/>
        <FooterPlus>
          <RatingButton rating={rating}/>
        </FooterPlus>
      </WoWsInfo>
    )
  };

  renderShip(item) {
    let ship = DATA[SAVED.warship][item.ship_id];
    return (
      <Touchable key={item.ship_id} onPress={() => SafeAction('PlayerShipDetail', {data: item})}>
        <WarshipCell item={ship} scale={1.8}/>
        <SimpleRating info={item}/>
      </Touchable>
    )
  }

  updateShip(data) {
    let sorted = filterShip(data, this.original);
    if (sorted == null) this.setState({data: this.original});
    else {
      let rating = getOverallRating(sorted);
      this.setState({data: sorted, rating: rating});
    }
  }
}

export { PlayerShip };
