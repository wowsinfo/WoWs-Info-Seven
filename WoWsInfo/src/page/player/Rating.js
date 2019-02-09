/**
 * Rating.js
 * 
 * 
 */

import React, { Component } from 'react';
import { View, ScrollView, StyleSheet } from 'react-native';
import { WoWsInfo, SectionTitle } from '../../component';
import { Text, Paragraph, Caption, DataTable } from 'react-native-paper';
import lang from '../../value/lang';
import { getRatingList, getColourList } from '../../core';

class Rating extends Component {
  render() {
    const { container, range } = styles;
    const ratingRange = ['0 - 750', '750 - 1100', '1100 - 1350', '1350 - 1550', '1550 - 1750', '1750 - 2100', '2100 - 2450', '2450 - 9999'];
    const ratingComments = getRatingList();
    const ratingColours = getColourList();

    return (
      <WoWsInfo title={lang.rating_author}>
        <ScrollView>
          <SectionTitle title='Personal Rating'/>
          <View style={container}>
            <Paragraph>{lang.rating_description}</Paragraph>
            <Caption>{lang.rating_warning}</Caption>
          </View>
          <SectionTitle title={lang.rating_scale}/>
          <DataTable>
            <DataTable.Header>
              <DataTable.Title>{lang.rating_title_skill}</DataTable.Title>
              <DataTable.Title numeric>{lang.rating_title_range}</DataTable.Title>
            </DataTable.Header>
            { ratingRange.map((v, i) => {
              const color = {color: ratingColours[i], fontWeight: 'bold'}
              return (
                <View style={range} key={v}>
                  <Text style={color}>{ratingComments[i]}</Text>
                  <Text style={color}>{v}</Text>
                </View>
              )
            }) }
          </DataTable>
        </ScrollView>
      </WoWsInfo>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    paddingLeft: 16,
    paddingRight: 16,
  },
  range: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    padding: 16
  }
});

export { Rating };
