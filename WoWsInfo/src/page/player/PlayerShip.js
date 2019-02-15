import React, { PureComponent } from 'react';
import { View, Image, StyleSheet } from 'react-native';
import { WoWsInfo, WarshipCell, Touchable, RatingButton, FooterPlus, SimpleRating } from '../../component';
import { getOverallRating, roundTo, getComment, getColourList, getColour, SafeAction } from '../../core';
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

    this.state = {
      data: ships.sort((a, b) => b.ap - a.ap),
      rating: rating
    };
  }

  render() {
    const { data, rating } = this.state;
    return (
      <WoWsInfo title={`${lang.wiki_warship_footer} - ${data.length}`}>
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
}

export { PlayerShip };
