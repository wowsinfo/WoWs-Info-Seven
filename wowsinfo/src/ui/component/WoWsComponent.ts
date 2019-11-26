/**
 * WoWsComponent.ts
 * All components should implement WoWsComponent but it is not actually a component
 */

/**
 * States shared by all components
 */
export interface WoWsState {
  /**
   * whether this component is loading 
   */
  loading: boolean,
  /**
   * error message (nothing means no error)
   */
  error: string
}

/**
 * The parent of all components.
 * It takes a prop, a state and anything else
 */
abstract class WoWsComponent {
  /**
   * if this is a pro feature
   */
  abstract isProFeature: boolean;
}

export { WoWsComponent };
