import React from 'react';
import { Text, View, StyleSheet, ScrollView } from 'react-native';
import { Actions } from 'react-native-router-flux';
import { WoWsLoading, OnlineGroup } from '../../component';
import { PlayerOnline } from '../../core/';
import strings from '../../localization';

class PlayerOnlineScreen extends React.PureComponent {
  state = {
    isReady: false,
    serverInfo: {},
  }

  async componentWillMount() {
    PlayerOnline.getPlayerOnline().then(info => {
      if (info.server.length == 4) {
        this.setState({
          isReady: true,
          serverInfo: info,
        }, () => {
          this.ru = info.server[0];
          this.eu = info.server[1];
          this.na = info.server[2];
          this.asia = info.server[3];
          this.total = info.total;
          Actions.refresh({title: global.gameVersion});
        })
      }
    })
  }

  render() {
    if (this.state.isReady) {
      return (
        <View style={viewStyle}>
          <ScrollView contentContainerStyle={scrollViewStyle}>
            <OnlineGroup title={strings.russia} info={this.ru}/>
            <OnlineGroup title={strings.europe} info={this.eu}/>         
            <Text style={[textStyle, {color: global.themeColour}]}>{this.total}</Text>
            <OnlineGroup title={strings.north_america} info={this.na}/>
            <OnlineGroup title={strings.asia} info={this.asia}/>
          </ScrollView>
        </View>
      )
    } else {
      return <WoWsLoading />
    }
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flex: 1,
    alignItems: 'center',
  },
  scrollViewStyle: {
    flex: 1,
    justifyContent: 'space-around',
  },
  textStyle: {
    fontSize: 64,
  }
})
const { viewStyle, scrollViewStyle, textStyle } = styles;

export {PlayerOnlineScreen};