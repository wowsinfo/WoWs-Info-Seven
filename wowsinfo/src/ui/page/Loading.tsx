import React, { Component } from "react";
import { WoWsComponent } from "../component/WoWsComponent";
import { Surface, withTheme, Theme, Colors } from "react-native-paper";
import { ConsumerForAll } from "../component";

interface LoadingProps {
  theme: Theme
}

class Loading extends Component<LoadingProps> implements WoWsComponent {
  isProFeature: boolean = false;

  constructor(props: LoadingProps) {
    super(props);
  }
  
  render() {
    return (
      <ConsumerForAll>
        { c => (
          <Surface style={{backgroundColor: c?.theme.getPrimary(), flex: 1}}>

          </Surface>
        )}
      </ConsumerForAll>
    );
  }
}

export { Loading };
