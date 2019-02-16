import React, { PureComponent } from 'react';
import { FlatList } from 'react-native';
import { WoWsInfo, WarshipCell, Touchable, RatingButton, FooterPlus, SimpleRating } from '../../component';
import { getOverallRating, roundTo, getComment, getColourList, getColour, SafeAction, filterShip, Guard } from '../../core';
import { FlatGrid } from 'react-native-super-grid';
import { SAVED } from '../../value/data';
import { lang } from '../../value/lang';
import { Button } from 'react-native-paper';

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
      filter: {},
      sortStr: ''
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
    const sortingMethod = [{n: lang.ship_sort_battle, v: 'pvp.battles'}, {n: lang.record_max_damage_dealt, v: 'pvp.max_damage_dealt'}, 
      {n: lang.basic_last_battle, v: 'last_battle_time'}, {n: lang.ship_sort_colour, v: 'rating'},
      {n: lang.record_max_xp, v: 'pvp.max_xp'}, {n: lang.record_max_frags_battle, v: 'pvp.max_frags_battle'}];

    return (
      <WoWsInfo title={`${lang.wiki_warship_footer} - ${data.length}`} onPress={() => SafeAction('WarshipFilter', {applyFunc: this.updateShip})}>
        <FlatGrid itemDimension={150} items={data} renderItem={({item}) => this.renderShip(item)} 
          showsVerticalScrollIndicator={false} fixed/>
        <FooterPlus>
          <FlatList data={sortingMethod} renderItem={({item}) => <Button style={{margin: 8}} mode='contained' onPress={() => this.sortData(item.v)}>{item.n}</Button>} 
            horizontal showsHorizontalScrollIndicator={false} keyExtractor={d => d.n}/>
          <RatingButton rating={rating}/>
        </FooterPlus>
      </WoWsInfo>
    )
  };

  sortData(v) {
    const { data, sortStr } = this.state;
    console.log(sortStr, v);
    if (v === sortStr) {
      // Simply reverse it
      this.setState({data: data.reverse(), sortStr: ''});
    } else {
      this.setState({data: data.sort((a, b) => Guard(b, v, 0) - Guard(a, v, 0)), sortStr: v});
    }
  }

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
      // Get rating again
      let rating = getOverallRating(sorted);
      this.setState({data: sorted, rating: rating});
    }
  }
}

export { PlayerShip };
