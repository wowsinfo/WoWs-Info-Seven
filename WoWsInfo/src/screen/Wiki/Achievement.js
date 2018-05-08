import React, { Component } from 'react';
import GridView from 'react-native-super-grid';
import { WoWsLoading, BasicCell, NoInformation } from '../../component';
import { View } from 'react-native-animatable';

class Achievement extends Component {
  state = {
    isReady: false, data: []
  }

  componentDidMount() {
    const { info } = this.props;
    this.setState({
      isReady: true, data: info
    });
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
      <View animation='fadeInUp'>
        <GridView itemDimension={80} items={data} contentInset={{bottom: 50}}
        renderItem={item => <BasicCell icon={item.icon} data={item} player/>}/>
      </View>
    )
  }
}

export { Achievement };