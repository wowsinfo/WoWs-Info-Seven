import React from 'react';
import GridView from 'react-native-super-grid';
import { Actions } from 'react-native-router-flux';
import { WoWsLoading, BasicCell } from '../../../component';

class AchievementScreen extends React.PureComponent {
  state = {
    isReady: false,
    data: [],
  }

  componentWillMount() {
    // Prase global.achievementJson and make it readable
    var parsed = [];
    for (key in global.achievementJson) {
      // Make naming unique
      var entry = Object.assign({}, global.achievementJson[key]);
      entry.key = key;
      entry.text = entry.description;
      delete entry.description;
      parsed.push(entry);
    }
    // Sort by hidden
    parsed.sort(function (a, b) {
      if (a.hidden) return 1;
      else if (a.hidden == b.hidden) return (a.name > b.name) ? 1 : -1;
      else return -1;
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
        <GridView itemDimension={80} items={this.state.data} 
          renderItem={item => {
            if (!item.hidden) return <BasicCell icon={item.image} data={item}/>
            else return <BasicCell icon={item.image_inactive} data={item}/>
          }} />
      )
    } else return <WoWsLoading />;
  }
}

export {AchievementScreen};