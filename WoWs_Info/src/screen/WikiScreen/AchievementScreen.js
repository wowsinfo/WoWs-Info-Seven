import React from 'react';
import { Text, Image, View } from 'react-native';
import GridView from 'react-native-super-grid';
import { Actions } from 'react-native-router-flux';
import { WikiCell } from '../../component';
import strings from '../../localization';

class AchievementScreen extends React.PureComponent {
  state = {
    isReady: false,
    data: [],
  }

  componentWillMount() {
    // Prase global.achievementJson and make it readable
    var parsed = [];
    for (key in global.achivementJson) {
      parsed.push(global.achivementJson[key]);
    }
    // Sort by hidden
    parsed.sort(function (a, b) {
      if (a.hidden) return 1;
      return -1;
    })
    console.log(parsed);
    this.setState({
      isReady: true,
      data: parsed,
    }, () => Actions.refresh({title: parsed.length}));
  }

  render() {
    if (this.state.isReady) {
      return (
        <GridView itemDimension={100} items={this.state.data} renderItem={item => {
          return (
            <View style={{flex: 1}}>
              <Image source={{uri: item.image}} style={{height: 100, width: 100}}/>
              <Text style={{textAlign: 'center'}}>{item.name}</Text>
            </View>
          )
        }} />
      )
    } else return null;
  }
}

export {AchievementScreen};