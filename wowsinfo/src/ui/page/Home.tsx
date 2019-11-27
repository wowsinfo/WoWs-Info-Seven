import { Component } from 'react';
import { WoWsComponent, WoWsState } from '../component/WoWsComponent';

interface HomeState extends WoWsState {

}

/**
 * The home page of this app
 * - It displays a tab navigation for mobiles
 * - It displays a drawer for tablets or devices with a larger display
 */
class Home extends Component<{}, HomeState> implements WoWsComponent {
  isProFeature: boolean = false;
  
  constructor(props: {}) {
    super(props);
  }
}

export { Home };
