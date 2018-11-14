import React, { Component } from 'react';
import { StyleSheet, SafeAreaView, ScrollView, StatusBar } from 'react-native';
import { withTheme, IconButton, Text, Colors, Surface, 
  Card, Title, Paragraph, DarkTheme, DefaultTheme } from 'react-native-paper';
import { FloatingButton, LoadingModal } from '../../component';
import { Actions } from 'react-native-router-flux';
import { DataLoader, Guard } from '../../core';
import { LOCAL } from '../../value/data';
import { BLUE, GREY } from 'react-native-material-color';

class Home extends Component {
  constructor(props) {
    super(props);

    this.state = {
      loading: true,
      dark: false
    }

    DataLoader.loadAll().then(data => {
      global.DATA = data;
      const appTheme = Guard(DATA, `${LOCAL.theme}`, BLUE);
      const darkMode = Guard(DATA, `${LOCAL.darkMode}`, true);

      let customised = {};
      // Decide whether dark mode is enabled
      if (darkMode) {
        customised = {
          colors: {
            ...DarkTheme.colors,
            surface: Colors.grey900,
            text: GREY[50],
            primary: appTheme[500],
            accent: appTheme[300],
          }
        };
      } else {
        customised = {
          colors: {
            ...DefaultTheme.colors,
            primary: appTheme[500],
            accent: appTheme[300],
          }
        };
      }

      console.log(customised);
      props.theme.roundness = 8;
      props.theme.dark = darkMode;
      props.theme.colors = customised.colors;

      this.setState({loading: false, dark: darkMode});
      // console.log(props);
    })
  }

  render() {
    const { container, playerLabel, header, card } = styles;
    const { loading, dark } = this.state;
    // Show loading modal while getting all data from Asyncstorage
    if (loading) return <LoadingModal />
    return (
      <Surface style={container}>
        <StatusBar barStyle={dark ? 'light-content' : 'dark-content'} 
          backgroundColor={dark ? GREY[900] : GREY[200]}/>
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

export default withTheme(Home);
