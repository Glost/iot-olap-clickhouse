import * as React from "react";

import "./styles.scss";

interface IProps {
    place: string;
}
interface IState {
    hi: string;
}

export default class ExampleView extends React.PureComponent<IProps, IState> {
    state = {
        hi: "Hello"
    };

    render() {
        const { hi } = this.state;
        const { place } = this.props;

        return <h3>{hi}, {place}!</h3>;
    }
}
