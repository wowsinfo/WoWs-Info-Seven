import React, { PureComponent } from 'react';
import { View, ActivityIndicator, SafeAreaView, Text, StyleSheet } from 'react-native';
import { Surface, Button } from 'react-native-paper';

class Statistics extends PureComponent {
  constructor(props) {
    super(props);
    // name, id and server
    // this.state = props.info;
    this.state = {
      name: 'HenryQuan',
      server: 3,
      // To check if certain data have been loaded correctly
      achievement: false,
      rank: false,
      ship: false,
      basic: false,
      graph: false
    }
  }

  render() {
    const { container } = styles;
    return (
      <Surface style={container}>
        <SafeAreaView>
          <Text>{this.state.name}</Text>
          { this.renderBasic() }
          { this.renderAchievement() }
          { this.renderShip() }
          { this.renderGraph() }
          { this.renderRank() }
        </SafeAreaView>
      </Surface>
    )
  };

  ///
  // I will do parallel data loading so each of them will have 
  // their own state to check if the button could be rendered
  ///

  renderAchievement() {
    const { achievement } = this.state;
    if (!achievement) return <ActivityIndicator />
    return <Button>achievement</Button>
  }

  renderShip() {
    const { ship } = this.state;
    if (!ship) return <ActivityIndicator />
    return <Button>ship</Button>    
  }

  renderRank() {
    const { rank } = this.state;
    if (!rank) return <ActivityIndicator />
    return <Button>rank</Button>
  }

  renderBasic() {
    const { basic } = this.state;
    if (!basic) return <ActivityIndicator />
    return <Button>basic</Button>
  }

  renderGraph() {
    const { graph } = this.state;
    if (!graph) return <ActivityIndicator />
    return <Button>graph</Button>
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16
  }
});

export { Statistics };
