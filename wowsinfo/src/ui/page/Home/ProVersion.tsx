import React, { Component } from 'react';
import { Surface, Appbar, List, Button, Divider } from 'react-native-paper';
import { StyleSheet, FlatList, ScrollView } from 'react-native';
import { Actions } from 'react-native-router-flux';
import { SetupProps, WoWsComponent } from 'src/ui/component/WoWsComponent';
import { langs } from 'src/core/value/Language';
import { ContainedButton } from 'src/ui/component';

export interface ProVersionProps extends SetupProps {

}

class ProVersion extends Component<ProVersionProps> implements WoWsComponent {
  isProFeature: boolean = false;

  constructor(props: ProVersionProps) {
    super(props);
  }

  render() {
    const { rootView } = styles;
    return (
      <Surface style={rootView}>
        <Appbar.Header>
          { this.props.isSetup ? null : <Appbar.BackAction /> }
          <Appbar.Content title={langs.proversion_title} />
        </Appbar.Header>
        <ScrollView>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
          <List.Item title='test test test test test test test' description='test 12345678900765432'/>
        </ScrollView>
        <Divider />
        <ContainedButton>
          Try it now for free
        </ContainedButton>
        { this.renderContainedButton() }
      </Surface>
    );
  }

  /**
   * This is the 'NEXT' or 'MAYBE LATER...' button
   */
  renderContainedButton() {
    if (this.props.isSetup) {
      return (
        <ContainedButton onPress={() => Actions.replace('Home')}>
          Maybe later
        </ContainedButton>
      )
    }

    return null;
  }
}

const styles = StyleSheet.create({
  rootView: {
    flex: 1
  },
})

export { ProVersion };
