import {Actions} from 'react-native-router-flux';

class SafeAction {
  /**
   * Add safe action to check if that screen already exists in the stack
   * max is for the case where you need to push another same screen
   * @param screen
   * @param obj
   */
  static push(screen: string, obj?: any) {
    if (
      // @ts-ignore
      Actions.state.routes.filter(
        (r: {routeName: any}) => r.routeName === screen,
      ).length > 0
    ) {
      console.log(`${screen} rejected`);
    } else {
      Actions.push(screen, obj);
      console.log(`${screen} pushed`);
    }
  }
}

export {SafeAction};
