import React, { Component } from 'react';
import { View, StyleSheet, ScrollView } from 'react-native';
import { WoWsInfo } from '../../component';
import { Title, List, Button, Caption, Text } from 'react-native-paper';

class ProVersion extends Component {
  constructor(props) {
    super(props);

  }

  render() {
    const { featureTitle, titleStyle, viewStyle, buttonView, restoreButton, discount } = styles;
    return (
      <WoWsInfo hideAds>
        <Title style={titleStyle}>WoWs Info Pro</Title>
        <ScrollView style={viewStyle}>
          <List.Section title='Features' style={featureTitle}>
            <List.Item title='RS Beta' description='Get realtime statistics in your battles' />
            <List.Item title='More Statisctis' description='Show even more statistics in your profile' />
            <List.Item title='More coming soon' description='More features are under development and will be added' />
          </List.Section>
        </ScrollView>
        <View style={buttonView}>
          <Text style={discount}>50% off for everyone until the next major update</Text>
          <Button mode='contained' theme={{roundness: 0}}>$ / Year</Button>
          <Button style={restoreButton}>Restore Pro Version</Button>
        </View>
      </WoWsInfo>
    )
  };
}

const styles = StyleSheet.create({
  viewStyle: {
    flex: 1
  },
  featureTitle: {
    marginTop: -8
  },
  titleStyle: {
    padding: 16,
    fontSize: 28,
    fontWeight: 'bold',
  },
  buttonView: {
    padding: 16
  },
  restoreButton: {
    marginTop: 16
  },
  discount: {
    textAlign: 'center',
    marginBottom: 4
  }
})

export { ProVersion };
