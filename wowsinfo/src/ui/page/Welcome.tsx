import { WoWsComponent, WoWsState } from "../component/WoWsComponent";
import { Component } from "react";
import { Surface, Text } from "react-native-paper";

export interface WelcomeState extends WoWsState {

}

export default class Welcome extends Component<{}, WelcomeState> implements WoWsComponent {
    isProFeature: boolean = false;

    constructor({}) {
        super({});
        this.state = {
            loading: false,
            error: ''
        }
    }

    render() {
        if (!this.state.loading) {
            return (
                <Surface>
                    <Text>Welcome to WoWs Info</Text>
                </Surface>
            )
        }
    }
}