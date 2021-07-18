/**
 * Map.js
 *
 * This is the wiki map
 */

import React, {Component} from 'react';
import {Image, StyleSheet, Dimensions} from 'react-native';
import {WoWsInfo, LoadingIndicator} from '../../component';
import {SAVED, setLastLocation} from '../../value/data';
import {List, Portal, Dialog} from 'react-native-paper';
import {FlatGrid} from 'react-native-super-grid';

class Map extends Component {
  constructor(props) {
    super(props);
    setLastLocation('Map');
    console.log('WIKI - Map');

    let map = DATA[SAVED.map];
    console.log(map);
    this.state = {
      data: map,
      shown: false,
      map: '',
      loading: true,
    };
  }

  render() {
    const {data, shown, map, loading} = this.state;
    const {indicator} = styles;

    // Get map dimension
    const {width, height} = Dimensions.get('window');
    let imageWidth = width > height ? height : width;
    imageWidth -= 20;

    return (
      <WoWsInfo>
        <FlatGrid
          data={data}
          itemDimension={300}
          spacing={0}
          renderItem={({item}) => {
            return (
              <List.Item
                title={item.name}
                description={item.description}
                key={item.name}
                onPress={() => this.setState({shown: true, map: item.icon})}
              />
            );
          }}
          showsVerticalScrollIndicator={false}
        />
        <Portal>
          <Dialog
            visible={shown}
            onDismiss={() => this.setState({shown: false, loading: true})}
            dismissable
            theme={{roundness: 16}}
            style={{
              height: imageWidth,
              width: imageWidth,
              alignSelf: 'center',
            }}>
            <Image
              source={{uri: map}}
              onLoadEnd={() => this.setState({loading: false})}
              style={{flex: 1, height: null, width: null, borderRadius: 16}}
            />
            {loading ? <LoadingIndicator style={indicator} /> : null}
          </Dialog>
        </Portal>
      </WoWsInfo>
    );
  }
}

const styles = StyleSheet.create({
  indicator: {
    position: 'absolute',
    top: 0,
    bottom: 0,
    left: 0,
    right: 0,
  },
});

export {Map};
