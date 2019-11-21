import { Path, LocationState } from "history";
import * as React from "react";
import { bindActionCreators, Dispatch } from "redux";
import { connect } from "react-redux";
import { push, CallHistoryMethodAction } from "connected-react-router";

import ExampleContainer from "@/containers/Example";

import { getFeedAction, TFeedActions } from "@/actions/feed";
import { initUserAction, TInitialActions } from "@/actions/initial";


interface IProps {
    pageId: string;
    pushStory: typeof pushStory;
    getFeedAction: typeof getFeedAction;
    initUserAction: typeof initUserAction;
}

interface IState {
    activePanel: "search" | any;
    onboarding: boolean;
}

class App extends React.PureComponent<IProps, IState> {
    componentDidMount() {
        this.props.initUserAction({});
    }

    render() {
        return <ExampleContainer place="World"/>;
    }
}

const pushStory = (
    story: Path,
    state?: LocationState
): CallHistoryMethodAction<[Path, LocationState?]> => push("/" + story, state);

const mapDispatchToProps = (
    dispatch: Dispatch<TInitialActions & TFeedActions>
) => {
    return bindActionCreators(
        {
            getFeedAction,
            initUserAction,
            pushStory
        },
        dispatch
    );
};

export default connect(
    null,
    mapDispatchToProps
)(App);
