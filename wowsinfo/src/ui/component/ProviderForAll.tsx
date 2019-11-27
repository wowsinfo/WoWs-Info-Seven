/**
 * ProviderForAll.tsx
 * This is a provider for everything (including theme, language and anything that needs to rerender the entire app)
 */

import React, { Component, ReactNode } from 'react';
import { Theme, DefaultTheme, Provider as PaperProvider, DarkTheme } from 'react-native-paper';

interface AllProps {
  children: ReactNode
}

interface AllState {
  theme: Theme,
  updateTheme(theme: Theme): void,
};

/// Export for other components
const ContextForAll =  React.createContext<AllState|null>(null);

class ProviderForAll extends Component<AllProps, AllState> {
  constructor(props: AllProps) {
    super(props);

    this.state = {
      // Theme and updateTheme from anywhere
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
      <ContextForAll.Provider value={this.state}>
        <PaperProvider theme={this.state.theme}>
          { children }
        </PaperProvider>
      </ContextForAll.Provider>
    );
  }
}

const ConsumerForAll = ContextForAll.Consumer;
export { ContextForAll, ConsumerForAll, ProviderForAll };
