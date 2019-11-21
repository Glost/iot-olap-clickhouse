import { createAction } from "redux-actions";
import { TLoadedAction } from "@/utils/typings/Actions";

export const INIT_USER: "INIT_USER" = "INIT_USER";

type TInitUserPayload = {
    user: any;
};

export const initUserAction = createAction(INIT_USER, (user: any) => ({ user }));

export type TInitialActions =
    | TLoadedAction<typeof INIT_USER, TInitUserPayload>;

