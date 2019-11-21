import { takeEvery } from "redux-saga/effects";

import { GET_FEED } from "@/actions/feed";
import { EXAMPLE_ACTION } from "@/actions/example";

import getFeedSaga from "@/sagas/feed";
import exampleSaga from "@/sagas/example";

export default function* rootSaga() {
    yield takeEvery(GET_FEED, getFeedSaga);
    yield takeEvery(EXAMPLE_ACTION, exampleSaga);
}
