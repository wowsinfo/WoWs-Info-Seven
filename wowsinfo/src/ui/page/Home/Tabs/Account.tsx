import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import WebView from 'react-native-webview';
import { Headline, Title, FAB } from 'react-native-paper';

export interface AccountProps {

}

interface AccountState {

}

/**
 * Account Class
 */
class Account extends Component<AccountProps, AccountState> {
  webview!: WebView | null;

  constructor(props: AccountProps) {
    super(props);
  }

  render() {
    const JS = `
      // Remove extra divs
      $('.footer-main, #main-top-menu, #common_menu, .mobile-socials__button, .categories-filter__header__title, .main-content__top, .load-more-btn, .mobile-scrollable__wrapper, .categories-filter__wrapper, ._divider').remove();
    `;

    const { container } = styles;
    return (
      <View style={container}>
        <Title>Welcome Back,</Title>
        <Headline>HenryQuan</Headline>
        <WebView source={{ uri: 'https://worldofwarships.asia/en/news/' }} ref={ref => (this.webview = ref)}
          onNavigationStateChange={request => {
          const { url } = request;
          let shouldLoad = url.startsWith('https://worldofwarships') && url.includes('news');
          if (!shouldLoad) this.webview?.stopLoading();
        }} injectedJavaScript={JS} allowsFullscreenVideo />
        <FAB icon='' label='Check my stats'/>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  }
});

export { Account };
