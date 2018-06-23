import React, { Component } from 'react';
import { SectionList, Text, StyleSheet } from 'react-native';
import { View } from 'react-native-animatable';
import language from '../../constant/language';
import { Divider } from 'react-native-elements';
import { getTheme, getTextColour } from '../../constant/colour';

const data = [{title: language.web_official_title, data: [language.web_official, language.web_premium_store, language.web_official_wiki]},
  {title: language.web_statistics_title, data: [language.web_number, language.web_today]},
  {title: language.web_information_title, data: [language.web_sea_group, language.web_daily_bounce, language.web_facebook]},
  {title: language.web_ranking_title, data: [language.web_ranking]}]

export default Website = () => {
  const { viewStyle, headerStyle, textStyle, titleStyle } = styles;
  return (
    <View animation='fadeIn' style={viewStyle}>
      <SectionList keyExtractor={(item, index) => item + index} sections={data}
        renderItem={({item, index, section}) => <Text style={textStyle} key={index}>{item}</Text>}
        renderSectionHeader={({section: {title}}) => (
          <View>
            <View style={[headerStyle, {backgroundColor: getTextColour()}]}><Text style={[titleStyle, {color: getTheme()}]}>{title}</Text></View>
            <Divider />
          </View>
        )}/>
    </View>
  )
}

const styles = StyleSheet.create({
  viewStyle: {
    flex: 1,
  },
  headerStyle: {
    padding: 8
  },
  textStyle: {
    marginLeft: 8,
    padding: 16
  },
  titleStyle: {
    fontWeight: 'bold', fontSize: 17
  }
})