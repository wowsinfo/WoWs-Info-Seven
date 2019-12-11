import React, { Component } from 'react';
import { WoWsComponent, SetupProps } from '../../component/WoWsComponent';

export interface ProVersionProps extends SetupProps {

}

class ProVersion extends Component<ProVersionProps> implements WoWsComponent {
  isProFeature: boolean = false;

  constructor(props: ProVersionProps) {
    super(props);
  }

  render() {
    return null;
  }
}

export { ProVersion };
