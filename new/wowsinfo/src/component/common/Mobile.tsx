/**
 * This is a root component for WoWs Info that has back button
 */

import { Component, ReactNode } from "react";
import WoWsInfoComponent from "../WoWsInfoComponent";

export interface Props {
    showBackButton: boolean;
    children: ReactNode
}

class Mobile extends Component<Props> implements WoWsInfoComponent {
    isProFeature: boolean = false;   
    showProBanner: boolean = false;
    showBackButton: boolean = false;
    props!: Props;

    constructor(props: Props) {
        super(props);
        this.showBackButton = props.showBackButton;
        this.props = props;
    }
    
    render() {
        return null;
    }
}

export { Mobile };
