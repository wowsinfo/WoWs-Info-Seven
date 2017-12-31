import React from 'react';
import { View, Image, Text } from 'react-native';
import GridView from 'react-native-super-grid';
import { WoWsLoading, BasicCell } from '../../../component';
import { styles } from './CollectionDetailScreenStyles';

class CollectionDetailScreen extends React.PureComponent {
  constructor(props) {
    super();
    this.state = {
      isReady: false,
      data: [],
    }
  }

  componentWillMount() {
    let json = global.collectionItemJson;
    var parsed = []; let collection = this.props.data.key;
    for (key in json) {
      let curr = json[key];
      if (curr.collection == collection) parsed.push(curr); // Right collection
    }    
    // Sorted by name
    parsed.sort(function(a, b) { return a.key - b.key });
    this.setState({
      isReady: true,
      data: parsed,
    });
  }

  render() {
    if (this.state.isReady) {
      return (
        <GridView itemDimension={80} items={this.state.data} renderHeader={this.renderHeader}
          renderItem={item => <BasicCell icon={item.icon} data={item}/>} />
      )
    } else return <WoWsLoading />;
  }

  renderHeader = () => {
    const { name, icon, text } = this.props.data;       
    const { viewStyle, imageStyle, nameStyle, textStyle } = styles; 
    return (
      <View style={viewStyle}>
        <Image style={imageStyle} source={{uri: icon}}/>
        <Text style={[nameStyle, {color: global.themeColour}]}>{name}</Text>
        <Text style={textStyle}>{text}</Text>
      </View>
    )
  }
}

export {CollectionDetailScreen};