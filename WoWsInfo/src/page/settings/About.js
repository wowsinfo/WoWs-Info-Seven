import React, { Component } from 'react';
import { View, ScrollView, StyleSheet } from 'react-native';
import { Title, List, Paragraph } from 'react-native-paper';
import { WoWsInfo } from '../../component';
import { lang } from '../../value/lang';

class About extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { container, scroll, logo } = styles;
    return (
      <WoWsInfo>
        <ScrollView>
          <View>
            <Title>{lang.app_name}</Title>
            <Paragraph>WoWs Info is ...</Paragraph>
            <List.Section title='Special Thanks'>
              <List.Item title='Auris2010k'/>
              <List.Item title='Zetesian'/>
            </List.Section>
            <Title>Coming soon...</Title>
          </View>
        </ScrollView>
      </WoWsInfo>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  }
});

export { About };
