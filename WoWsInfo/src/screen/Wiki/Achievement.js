import React, { Component } from 'react';
import GridView from 'react-native-super-grid';
import { WoWsLoading, BasicCell, NoInformation } from '../../component';

class Achievement extends Component {
  state = {
    isReady: false,
    data: [],
    withCount: false,
  }

  componentDidMount() {
    // Prase global.achievementJson and make it readable
    const { info } = this.props;
    if (info != null) {
      this.setState({
        isReady: true,
        data: info,
        withCount: true,
      });
    } else {
      var parsed = []; let json = global.achievementJson;
      for (key in json) parsed.push(json[key]);
      // Sort by hidden
      parsed.sort(function (a, b) {
        if (a.hidden == b.hidden) return (a.name < b.name) ? 1 : -1;
        else return (a.hidden > b.hidden) ? 1 : -1;
      })
      // console.log(parsed);
      this.setState({
        isReady: true,
        data: parsed,
      }, () => Actions.refresh({title: parsed.length}));
    }
  }

  render() {
    const { isReady } = this.state;
    if (isReady) return this.renderGridView();
    else return <WoWsLoading />;
  }

  renderGridView() {
    const { data, withCount } = this.state;
    if (data.length == 0) return <NoInformation />
    else return (
      <GridView itemDimension={80} items={data} contentInset={{bottom:50}} 
        renderItem={item => <BasicCell icon={item.icon} data={item}/>}/>
    )
  }
}

export { Achievement };