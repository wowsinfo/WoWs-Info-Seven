import { getPro } from "../../value/data";
import { Actions } from "react-native-router-flux";

/**
 * Whether push to pro version screen
 */
export const pushToProVersion = () => {
    let pro = getPro();
    if (pro) return false;
    
    Actions.push('Pro');
    return true;
}