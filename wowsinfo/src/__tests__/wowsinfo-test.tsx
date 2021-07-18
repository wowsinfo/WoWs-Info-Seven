/**
 * @format
 */

import 'react-native';
import React from 'react';
import App from '../wowsinfo';

// Note: test renderer must be required after react-native
import renderer from 'react-test-renderer';

// Test app render correcly
it('wows info renders correctly', () => {
  renderer.create(<App />);
});
