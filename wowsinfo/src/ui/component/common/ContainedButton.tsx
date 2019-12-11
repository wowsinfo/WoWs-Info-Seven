import React, { Component } from "react";
import { WoWsComponent } from "../WoWsComponent";
import { StyleSheet } from "react-native";
import { Button } from "react-native-paper";

export interface ContainedButtonProps {
  onPress?: (() => void),
  children: React.ReactNode,
}

/**
 * A button at the bottom with 16px margin
 */
class ContainedButton extends Component<ContainedButtonProps> implements WoWsComponent {
  isProFeature: boolean = false;

  constructor(props: ContainedButtonProps) {
    super(props);
  }

  render() {
    const { children, onPress } = this.props;
    return (
      <Button  mode='contained' style={styles.ContainedButton} onPress={onPress}>
        {children}
      </Button>
    );
  }
}

const styles = StyleSheet.create({
  ContainedButton: {
    margin: 8
  }
});

export { ContainedButton };
