import React, { Component } from 'react';
import { StyleSheet, Text, StatusBar, SafeAreaView, ScrollView, View, ActivityIndicator } from 'react-native';
import { IconButton, Colors, Divider, Surface, Card, Title, Paragraph, Portal, Modal } from 'react-native-paper';
import { MenuButton, LoadingModal } from './component';

export default class App extends Component {
  render() {
    const { container, playerLabel, header, card } = styles;
    return (
      <View style={container}>
        <StatusBar />
        <SafeAreaView style={{height: '100%'}}>
          <View style={header}>
            <Text style={playerLabel}>HenryQuan</Text>
            <IconButton icon='settings' size={24} color={Colors.grey500}
              onPress={() => console.log('Pressed')}/>
          </View>
          <Divider/>
          <ScrollView contentContainerStyle={{paddingBottom: 24}}>
            <Card style={card}>
              <Card.Content>
                <Title>Card title</Title>
                <Paragraph>Card content</Paragraph>
              </Card.Content>
            </Card>
            <Card style={card}>
              <Card.Content>
                <Title>Card title</Title>
                <Paragraph>Card content</Paragraph>
              </Card.Content>
            </Card>
            <Card style={card}>
              <Card.Content>
                <Title>Card title</Title>
                <Paragraph>Card content</Paragraph>
              </Card.Content>
            </Card>
            <Card style={card}>
              <Card.Content>
                <Title>Card title</Title>
                <Paragraph>Card content</Paragraph>
              </Card.Content>
            </Card>
            <Card style={card}>
              <Card.Content>
                <Title>Card title</Title>
                <Paragraph>Card content</Paragraph>
              </Card.Content>
            </Card>
            <Card style={card}>
              <Card.Content>
                <Title>Card title</Title>
                <Paragraph>Card content</Paragraph>
              </Card.Content>
            </Card>
            <Card style={card}>
              <Card.Content>
                <Title>Card title</Title>
              </Card.Content>
            </Card>
          </ScrollView>
          <MenuButton />
          <LoadingModal />
        </SafeAreaView>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 8
  },
  header: {
    width: '100%', 
    flexDirection: 'row', 
    justifyContent: 'space-between'
  },
  playerLabel: {
    fontSize: 32,
    fontWeight: 'bold'
  },
  card: {
    borderRadius: 8,
    margin: 8,
    elevation: 2
  }
});
