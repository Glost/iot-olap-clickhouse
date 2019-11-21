import { put } from "redux-saga/effects";

import { exampleLoadedAction } from "@/actions/example";

export default function* () {
    try {
        throw new Error("Example");
    } catch (e) {
        yield put(exampleLoadedAction("example"));
    }
}
