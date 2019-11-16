import React, { Component, ReactNode } from "react";
import { Theme, DefaultTheme, Provider as PaperProvider, DarkTheme } from "react-native-paper";

interface ThemeProps {
  children: ReactNode
}

interface ThemeState {
  theme: Theme,
  updateTheme(theme: Theme): void,
};

/// Export for other components
const MyThemeContext =  React.createContext<ThemeState|null>(null);
export const ThemeContext = MyThemeContext;
export const ThemeConsumer = MyThemeContext.Consumer;

export default class ThemeProvider extends Component<ThemeProps, ThemeState> {
  constructor(props: ThemeProps) {
    super(props);

    // default state
    this.state = {
      theme: DefaultTheme,
      updateTheme: (newTheme) => {
        this.setState({
          theme: newTheme
        });
      }
    }
  }

  render() {
    const { children } = this.props;

    // Wrap around paper provider
    return (
      <MyThemeContext.Provider value={this.state}>
        <PaperProvider theme={this.state.theme}>
          { children }
        </PaperProvider>
      </MyThemeContext.Provider>
    );
  }
}
