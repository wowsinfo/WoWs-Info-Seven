import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';

export interface WebsiteProps {

}

interface WebsiteState {

}

/**
 * Website Class
 */
class Website extends Component<WebsiteProps, WebsiteState> {
  constructor(props: WebsiteProps) {
    super(props);
  }

  render() {
    const { container } = styles;
    return (
      <View style={container}>
        <Text>Website</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  }
});

export { Website };

// Move webview here
// const JS = `
//   // Remove extra divs
//   $('.footer-main, #main-top-menu, #common_menu, .mobile-socials__button, .categories-filter__header__title, .main-content__top, .load-more-btn, .mobile-scrollable__wrapper, .categories-filter__wrapper, ._divider').remove();
// `;
{/* <WebView source={{ uri: 'https://worldofwarships.asia/en/news/' }} ref={ref => (this.webview = ref)}
  onNavigationStateChange={request => {
  const { url } = request;
  let shouldLoad = url.startsWith('https://worldofwarships') && url.includes('news');
  if (!shouldLoad) this.webview?.stopLoading();
}} injectedJavaScript={JS} allowsFullscreenVideo /> */}