import { Component } from 'react';
import { WoWsComponent, WoWsState } from '../component/WoWsComponent';

interface HomeState extends WoWsState {

}

class Home extends Component<{}, HomeState> implements WoWsComponent {
  isProFeature: boolean = false;
  
  constructor(props: {}) {
    super(props);
  }
}

export { Home };
