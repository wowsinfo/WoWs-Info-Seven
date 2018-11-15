import React, { Component } from 'react';
import { StyleSheet, SafeAreaView, ScrollView, StatusBar } from 'react-native';
import { IconButton, Text, Colors, Surface, 
  Card, Title, Paragraph } from 'react-native-paper';
import { FloatingButton } from '../../component';
import { Actions } from 'react-native-router-flux';
import { LOCAL } from '../../value/data';
import { GREY } from 'react-native-material-color';

class Home extends Component {
  constructor(props) {
    super(props);

    this.state = {
      dark: DATA[LOCAL.theme]
    }
  }

  render() {
    const { container, playerLabel, header, card } = styles;
    const { dark } = this.state;
    return (
      <Surface theme={{colors: {background: GREY[800]}}} style={container}>
        <StatusBar barStyle={dark ? 'light-content' : 'dark-content'} 
          backgroundColor={dark ? 'black' : GREY[200]}/>
        <SafeAreaView style={{height: '100%'}}>
          <Surface style={header}>
            <Text numberOfLines={1} style={playerLabel}>HenryQuan</Text>
            <IconButton icon='settings' size={24} color={Colors.grey500}
              onPress={() => Actions.Settings()}/>
          </Surface>
          <ScrollView contentContainerStyle={{padding: 8}}>
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
          <FloatingButton />
        </SafeAreaView>
      </Surface>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    width: '100%', 
    flexDirection: 'row', 
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 8
  },
  playerLabel: {
    fontSize: 32,
    padding: 8,
    width: '80%',
    fontWeight: 'bold'
  },
  card: {
    borderRadius: 8,
    margin: 8,
    elevation: 2
  }
});

export { Home };
