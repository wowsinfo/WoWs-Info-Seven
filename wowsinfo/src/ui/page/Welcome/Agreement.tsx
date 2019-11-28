import React, { Component } from "react";
import { WoWsComponent } from "src/ui/component/WoWsComponent";
import { Surface, Button } from "react-native-paper";
import { Actions } from "react-native-router-flux";

class Agreement extends Component implements WoWsComponent {
  isProFeature: boolean = false;

  render() {
    return (
      <Surface>
        <Button onPress={() => Actions.replace('Welcome')}>Back</Button>
      </Surface>
    )
  }
}

export { Agreement };
