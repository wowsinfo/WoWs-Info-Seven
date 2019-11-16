import { PureComponent, ReactNode } from 'react';

/**
 * Props shared by all components
 */
export interface WoWsProps {

}

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
 * The parent of all components
 */
abstract class WoWsComponent extends PureComponent<WoWsProps, WoWsState> {
  /**
   * if this is a pro feature
   */
  isProFeature: boolean = false;

  abstract render(): ReactNode
}

export { WoWsComponent };