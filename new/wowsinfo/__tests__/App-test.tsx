/**
 * @format
 */

import 'react-native';
import React from 'react';

// Note: test renderer must be required after react-native.
import renderer from 'react-test-renderer';
import { WoWsInfoData } from '../src/core/data/WoWsInfoData';

/**
 * Test UI
 */


/**
 * Test Data 
 */
it('WoWsInfoData singleton - same instance', () => {
  // Make sure WoWsInfoData only has one instance
  expect(WoWsInfoData.instance === WoWsInfoData.instance).toBeTruthy();
});
