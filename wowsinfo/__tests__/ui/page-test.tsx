/**
 * @format
 */

import 'react-native';
import React from 'react';
import App from '../../src/App';

// Note: test renderer must be required after react-native.
import renderer from 'react-test-renderer';
import { Agreement, About, Settings, Account, RS, Search, Website, Wiki } from '../../src/ui/page';

it('Agreement renders correctly', () => {
  renderer.create(<Agreement />);
});

it('About (setup) renders correctly', () => {
  renderer.create(<About isSetup />);
});

it('About renders correctly', () => {
  renderer.create(<About isSetup={false} />);
});

it('Settings (setup) renders correctly', () => {
  renderer.create(<Settings isSetup />);
});

it('Settings renders correctly', () => {
  renderer.create(<Settings isSetup={false} />);
});

it('Account renders correctly', () => {
  renderer.create(<Account />);
});

it('RS renders correctly', () => {
  renderer.create(<RS />);
});

it('Search renders correctly', () => {
  renderer.create(<Search />);
});

it('Website renders correctly', () => {
  renderer.create(<Website />);
});

it('Wiki renders correctly', () => {
  renderer.create(<Wiki />);
});
