/**
 * The entry point of this app
 */

import * as React from 'react';
import { AppRegistry } from 'react-native';
import { name as WoWsInfo } from './app.json';
import App from './src/App';
import { ProviderForAll } from './src/ui/component/common/ProviderForAll';

export default function Main() {
  return (
    <ProviderForAll>
      <App />
    </ProviderForAll>
  );
};

AppRegistry.registerComponent(WoWsInfo, () => Main);