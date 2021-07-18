/**
 * SimilarGraph.js
 *
 * Displaying all similar ships' average stats
 */

import React, {PureComponent} from 'react';
import {ScrollView, StyleSheet} from 'react-native';
import {WoWsInfo, LoadingIndicator} from '../../component';

class SimilarGraph extends PureComponent {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <WoWsInfo>
        <ScrollView
          contentContainerStyle={styles.scroll}
          showsVerticalScrollIndicator={false}>
          {this.props.info}
        </ScrollView>
      </WoWsInfo>
    );
  }
}

const styles = StyleSheet.create({
  scroll: {
    padding: 8,
  },
});

export {SimilarGraph};
