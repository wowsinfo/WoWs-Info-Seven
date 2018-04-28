import React, { Component } from 'react';
import { ScrollView, Text, View } from 'react-native';
import { TextCell } from '../../component';
import language from '../../constant/language';
import { Divider } from 'react-native-elements';
import { getTextColour } from '../../constant/colour';

const data = [[language.web_official_title, {title: language.web_official}, {title: language.web_premium_store}, {title: language.web_official_wiki}], 
              [language.web_statistics_title, {title: language.web_number}, {title: language.web_today}], 
              [language.web_information_title, {title: language.web_sea_group}, {title: language.web_daily_bounce}, {title: language.web_facebook}], 
              [language.web_ranking_title, {title: language.web_ranking}]];

export default Website = () => {
  return (
    <ScrollView>
      { renderWebsite(data) }
    </ScrollView>
  )
}

renderWebsite = (data) => {
  return data.map(function(info, index) {    
    return info.map(function(info, index) {
      // console.log(info, index);
      if (index == 0) {      
        return (   
          <Text key={info} style={{padding: 8, backgroundColor: getTextColour(theme[500]), color: theme[500], fontWeight: 'bold'}}>{info}</Text>
      )} else return <TextCell key={info.title} title={info.title}/>
    })
  })
}