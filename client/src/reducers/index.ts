import { combineReducers } from "redux";
import { connectRouter } from "connected-react-router";
import { History } from "history";

import example from "@/reducers/example";
import feed from "@/reducers/feed";
import initial from "@/reducers/initial";

// TODO: make nested structure
// const rootReducer = combineReducers({
//     stuff: combineReducers({
//         innerStuff: combineReducers({
//             something
//         })
//     })
// });

export default (history: History) => combineReducers({
    example,
    feed,
    initial,
    router: connectRouter(history),
});
