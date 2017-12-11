import React from 'react';
import { Text, View } from 'react-native';
import { Actions } from 'react-native-router-flux';
import { WoWsLoading } from '../../component';
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
        <View>
          <View>
            <Text>{strings.russia}</Text>
            <Text>{this.ru}</Text>
          </View>
          <View>
            <Text>{strings.europe}</Text>
            <Text>{this.eu}</Text>
          </View>
          <View>
            <Text>{strings.north_america}</Text>
            <Text>{this.na}</Text>
          </View>
          <View>
            <Text>{strings.asia}</Text>
            <Text>{this.asia}</Text>
          </View>
        </View>
      )
    } else {
      return <WoWsLoading />
    }
  }
}

export {PlayerOnlineScreen};