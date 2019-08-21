export interface WoWsInfoComponent {
    /**
     * Whether this is a pro feature
     */
    isProFeature: boolean;
}

export interface CommonProps {
    /**
     * Whether this shows the pro banner
     */
    showProBanner?: boolean;

    /**
     * Whether this needs a back button (pure view or wrap around with Mobile/Tablet)
     */
    showBackButton?: boolean;
}
