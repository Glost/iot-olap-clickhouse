import * as React from "react";
import { render } from "react-dom";
import { Provider } from "react-redux";
import { Route } from "react-router";
import { ConnectedRouter } from "connected-react-router";

import App from "@/App";
import { store, history } from "@/store";

const renderApp = (AppComponent: any) => {
    const root = document.getElementById("root");

    render(
        <Provider store={store}>
            <ConnectedRouter history={history}>
                <Route
                    path="/:pageId?"
                    component={props => (
                        <AppComponent pageId={props.match.params.pageId} />
                    )}
                />
            </ConnectedRouter>
        </Provider>,
        root
    );
};

renderApp(App);

// Hot Module Replacement API
declare let module: { hot: any };

if (module.hot) {
    module.hot.accept("./App", () => {
        renderApp(require("./App").default);
    });
}
