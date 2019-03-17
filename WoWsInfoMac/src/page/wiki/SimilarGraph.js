/**
 * SimilarGraph.js
 * 
 * Displaying all similar ships' average stats
 */

import React, { PureComponent } from 'react';
import { ScrollView, StyleSheet } from 'react-native';
import { WoWsInfo, LoadingIndicator } from '../../component';

class SimilarGraph extends PureComponent {
  constructor(props) {
    super(props);
    this.state = {
      loading: true,
      chart: props.info
    };
    setTimeout(() => this.setState({loading: false}), 300);
  }

  render() {
    const { loading, chart } = this.state;
    return (
      <WoWsInfo>
        <ScrollView contentContainerStyle={styles.scroll} showsVerticalScrollIndicator={false}>
          { loading ? <LoadingIndicator /> : chart}
        </ScrollView>
      </WoWsInfo>
    )
  };
}

const styles = StyleSheet.create({
  scroll: {
    padding: 8
  }
});

export { SimilarGraph };
