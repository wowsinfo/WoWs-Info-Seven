import { PureComponent } from 'react';

/**
 * Props shared by all components
 */
export interface WoWsProps {

}

/**
 * States shared by all components
 * - Loading (whether it is loading)
 * - error (whether it fails to load)
 */
export interface WoWsState {
  loading: boolean,
  error: boolean
}

/**
 * The parent of all components
 */
export default abstract class WoWsComponent extends PureComponent<WoWsProps, WoWsState> {
  /**
   * if this is a pro feature
   */
  isProFeature: boolean = false;
}