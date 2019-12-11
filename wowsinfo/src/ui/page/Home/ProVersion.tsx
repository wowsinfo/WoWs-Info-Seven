import React, { Component } from 'react';
import { WoWsComponent, SetupProps } from '../../component/WoWsComponent';
import { Surface, Appbar, List, Button } from 'react-native-paper';
import { StyleSheet, FlatList, ScrollView } from 'react-native';
import { langs } from '../../../core/value/Language';

export interface ProVersionProps extends SetupProps {

}

class ProVersion extends Component<ProVersionProps> implements WoWsComponent {
  isProFeature: boolean = false;

  constructor(props: ProVersionProps) {
    super(props);
  }

  render() {
    const { rootView, bottomButton } = styles;
    return (
      <Surface style={rootView}>
        <Appbar.Header>
          <Appbar.Content title={langs.proversion_title} />
        </Appbar.Header>
        <ScrollView>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
        </ScrollView>
        <Button mode='contained' style={bottomButton}>
          Try it now for free
        </Button>
        { this.renderBottomButton() }
      </Surface>
    );
  }

  /**
   * This is the 'NEXT' or 'MAYBE LATER...' button
   */
  renderBottomButton() {
    if (this.props.isSetup) {
      const { bottomButton } = styles;
      return (
        <Button style={bottomButton}>
          Maybe later
        </Button>
      )
    }

    return null;
  }
}

const styles = StyleSheet.create({
  rootView: {
    flex: 1
  },
  bottomButton: {
    margin: 8
  }
})

export { ProVersion };
