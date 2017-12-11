import React from 'react';
import { Text, View, StyleSheet } from 'react-native';
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
          this.ru = this.state.serverInfo.server[0];
          this.eu = this.state.serverInfo.server[1];
          this.na = this.state.serverInfo.server[2];
          this.asia = this.state.serverInfo.server[3];
          this.total = this.state.serverInfo.total;
          Actions.refresh({title: this.total});
        })
      }
    })
  }

  render() {
    if (this.state.isReady) {
      return (
        <View style={viewStyle}>
          <OnlineGroup title={strings.russia} info={this.ru}/>
          <OnlineGroup title={strings.europe} info={this.eu}/>
          <OnlineGroup title={strings.north_america} info={this.na}/>
          <OnlineGroup title={strings.asia} info={this.asia}/>
        </View>
      )
    } else {
      return <WoWsLoading />
    }
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flexDirection: 'row',
    paddingTop: 16,
    justifyContent: 'space-around',
  }
})
const { viewStyle } = styles;

export {PlayerOnlineScreen};