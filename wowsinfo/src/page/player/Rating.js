/**
 * Rating.js
 *
 * This is a page explaining what is Personal Rating
 */

import React, {Component} from 'react';
import {View, ScrollView, Linking, StyleSheet} from 'react-native';
import {WoWsInfo, SectionTitle} from '../../component';
import {Text, Paragraph, Caption, Button} from 'react-native-paper';
import {lang} from '../../value/lang';
import {getRatingList, getColourList, SafeAction} from '../../core';
import {APP} from '../../value/data';

class Rating extends Component {
  render() {
    const {container, range} = styles;
    const ratingRange = [
      '0',
      '1 - 750',
      '750 - 1100',
      '1100 - 1350',
      '1350 - 1550',
      '1550 - 1750',
      '1750 - 2100',
      '2100 - 2450',
      '2450 - 9999',
    ];
    const ratingComments = getRatingList();
    const ratingColours = getColourList();

    return (
      <WoWsInfo
        title={lang.rating_author}
        onPress={() =>
          SafeAction(
            'Statistics',
            {info: {nickname: 'Wiochi', account_id: 503367319, server: 1}},
            1,
          )
        }>
        <ScrollView>
          <SectionTitle title={lang.rating_title} />
          <View style={container}>
            <Paragraph>{lang.rating_description}</Paragraph>
            <Caption>{lang.rating_warning}</Caption>
          </View>
          <SectionTitle title={lang.rating_scale} />
          {ratingRange.map((v, i) => {
            const color = {color: ratingColours[i], fontWeight: 'bold'};
            return (
              <View style={range} key={v}>
                <Text style={color}>{ratingComments[i]}</Text>
                <Text style={color}>{v}</Text>
              </View>
            );
          })}
          <Button onPress={() => Linking.openURL(APP.PersonalRating)}>
            {lang.rating_read_more}
          </Button>
        </ScrollView>
      </WoWsInfo>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    paddingLeft: 16,
    paddingRight: 16,
  },
  range: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    padding: 16,
  },
});

export {Rating};
