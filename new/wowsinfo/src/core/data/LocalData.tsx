/**
 * This class loads local data into memory and also updates and saves key-value
 */
export class LocalData {
    public constructor() {

    }

}

export const LocalDataKeys = {
    /**
     * A list of friends
     */
    FriendList: '@WoWs_Info:playerList',
    /**
     * Main account info (id, name and server)
     */
    MainAccountInfo: '@WoWs_Info:userInfo',
    /**
     * TODO: save pasted user data in a list
     */
    MainAccountData: '@WoWs_Info:userData',
    /**
     * Current server (NA, RU, EU, ASIA)
     */
    APIServer: '@WoWs_Info:currServer',
    /**
     * Current app version used to update data from API
     */
    AppVersion: '@WoWs_Info:currVersion',
    /**
     * Current game version
     */
    GameVersion: '@WoWs_Info:gameVersion',
    /**
     * TODO: This will be used to check if main account data needs to be saved or not
     */
    CurrDate: '@WoWs_Info:currDate',
    /**
     * TODO: This will be used to check if main account data needs to be saved or not
     */
    LastUpdate: '@WoWs_Info:lastUpdate',
    /**
     * Theme colour that is currently using
     */
    ThemeColour: '@WoWs_Info:themeColour',
    /**
     * Use dark mode or not
     */
    DarkMode: '@WoWs_Info:darkMode',
    /**
     * Swap bottom buttons or not
     */
    SwapButton: '@WoWs_Info:swapButton',
    /**
     * Hide all images (to save data)
     */
    ImageFreeMode: '@WoWs_Info:noImageMode',
    /**
     * Is it the first time using this app?
     */
    AppFirstLaunch: '@WoWs_Info:firstLaunch',
    /**
     * The language used for API request
     */
    ApiLanguage: '@WoWs_Info:apiLanguage',
    /**
     * The language user chooses to use
     */
    UserLanguage: '@WoWs_Info:userLanguage',
    /**
     * Last visited location (like wiki, main account and so on)
     */
    LastVisited: '@WoWs_Info:lastLocation',
    /**
     * This saves last entered IP address for WoWs RS
     */
    WoWsRsIP: '@WoWs_Info:rsIP',
    /**
     * Whether user unlocks pro features or not
     */
    ProVersion: '@WoWs_Info:pro'
};
