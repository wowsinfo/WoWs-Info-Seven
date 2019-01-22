import React, { PureComponent } from 'react';
import { View, SafeAreaView, Text, StyleSheet } from 'react-native';
import { Surface, Button, IconButton } from 'react-native-paper';
import { LOCAL } from '../../value/data';
import { GREY } from 'react-native-material-color';
import { LoadingIndicator } from '../../component';

class Statistics extends PureComponent {
  constructor(props) {
    super(props);
    // name, id and server
    // this.state = props.info;
    this.state = {
      name: 'HenryQuan',
      server: 3,
      // To check if certain data have been loaded correctly
      achievement: true,
      rank: false,
      ship: false,
      basic: false,
      graph: false
    }
  }

  render() {
    const { container, buttons } = styles;
    return (
      <Surface style={container}>
        <SafeAreaView>
          <Text>{this.state.name}</Text>
          { this.renderBasic() }
          <View style={buttons}>
            { this.renderAchievement() }
            { this.renderShip() }
            { this.renderGraph() }
            { this.renderRank() }
          </View>

        </SafeAreaView>
      </Surface>
    )
  };

  ///
  // I will do parallel data loading so each of them will have 
  // their own state to check if the button could be rendered
  ///

  renderBasic() {
    const { container, buttons } = styles;
    const { basic } = this.state;

    if (!basic) return <LoadingIndicator />
    return (
      <View>
      </View>
    )
  }

  renderAchievement() {
    const { container, buttons } = styles;
    const { achievement } = this.state;

    if (!achievement) return <LoadingIndicator />
    return (
      <Button>Achievement</Button>
    )
  }

  renderShip() {
    const { container, buttons } = styles;
    const { ship } = this.state;

    if (!ship) return <LoadingIndicator />
    return <Button>ship</Button>    
  }

  renderRank() {
    const { container, buttons } = styles;
    const { rank } = this.state;

    if (!rank) return <LoadingIndicator />
    return <Button>rank</Button>
  }

  renderGraph() {
    const { container, buttons } = styles;
    const { graph } = this.state;

    if (!graph) return <LoadingIndicator />
    return <Button>graph</Button>
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16
  },
  buttons: {
    flexDirection: 'row',
    justifyContent: 'space-around'
  }
});

export { Statistics };
