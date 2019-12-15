
import React, { Component, ReactNode } from 'react';
import { Provider as PaperProvider, Colors } from 'react-native-paper';
import { CustomTheme } from '../../../core/model';
import { languageAvailable, langs } from '../../../core/value/Language';

interface AllProps {
  children: ReactNode
}

interface AllState {
  theme: CustomTheme,
  updateTheme(theme: CustomTheme): void,
  language: string,
  updateLanguage(lang: string): void,
};

/// Export for other components
const ContextForAll =  React.createContext<AllState|null>(null);

/**
 * This is a provider for everything (including theme, language and anything that needs to rerender the entire app)
 */
class ProviderForAll extends Component<AllProps, AllState> {
  constructor(props: AllProps) {
    super(props);

    this.state = {
      // Theme and updateTheme from anywhere
      theme: new CustomTheme(false, Colors.red500),
      updateTheme: (newTheme) => {
        this.setState({
          theme: newTheme
        });
      },
      // update app language
      language: languageAvailable.en,
      updateLanguage: (newLang) => {
        langs.setLanguage(newLang);
      }
    }

    // set the default language
    langs.setLanguage(this.state.language);
  }

  render() {
    const { children } = this.props;
    const { theme } = this.state;

    // Wrap around paper provider
    return (
      <ContextForAll.Provider value={this.state}>
        <PaperProvider theme={theme.getTheme()}>
          { children }
        </PaperProvider>
      </ContextForAll.Provider>
    );
  }
}

const ConsumerForAll = ContextForAll.Consumer;
export { ContextForAll, ConsumerForAll, ProviderForAll };
