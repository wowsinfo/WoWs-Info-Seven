import React, { Component } from 'react';
import { View, Text, ScrollView } from 'react-native';
import language from '../../constant/language';
import { TextCell } from '../../component';

const data = [{title: language.tool_wrinfo}, {title: language.tool_assist}];

export default Tool = () => {
  return (
    <ScrollView>
      { renderSection(data) }
    </ScrollView>
  )
}

renderSection = (data) => {
  return data.map(function(info, index) {
    return <TextCell key={index} title={info.title}/>
  })
}