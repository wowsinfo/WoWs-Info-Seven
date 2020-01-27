import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { WebView } from 'react-native-webview';

export interface AccountProps {

}

interface AccountState {

}

/**
 * Account Class
 */
class Account extends Component<AccountProps, AccountState> {
  constructor(props: AccountProps) {
    super(props);
  }

  render() {
    const JS = "$('.footer-main, #main-top-menu, #common_menu, .mobile-socials__button, .categories-filter__header__title').remove();";
    const { container } = styles;
    return (
      <View style={container}>
        <WebView source={{ uri: 'https://worldofwarships.asia/en/news/' }} style={{flex: 0.5, height: '50%'}}
          onShouldStartLoadWithRequest={(event) => {
          console.log(event.url);
          const { url } = event;
          let shouldLoad = url.startsWith('https://worldofwarships') && url.includes('news');
          return false;
        }} injectedJavaScript={JS}
        allowsFullscreenVideo originWhitelist={['https://wprldofwarships*']}/>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  }
});

export { Account };
