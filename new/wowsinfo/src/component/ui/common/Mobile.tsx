/**
 * This is a root component for WoWs Info that has back button
 */

import { Component, ReactNode } from "react";
import { WoWsInfoComponent, CommonProps } from "../../WoWsInfoComponent";

export interface MobileProps extends CommonProps {
    children: ReactNode
    showProBanner: boolean
}

class Mobile extends Component<MobileProps> implements WoWsInfoComponent {
    isProFeature = false;
    showProBanner: boolean;   
    props: MobileProps;

    constructor(props: MobileProps) {
        super(props);
        this.showProBanner = props.showProBanner;
        this.props = props;
    }
    
    render() {
        return null;
    }
}

export { Mobile };
