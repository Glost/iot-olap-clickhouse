import { INIT_USER, TInitialActions } from "@/actions/initial";

export default (state = {}, action: TInitialActions) => {
    switch (action.type) {
        case INIT_USER:
            return {
                ...state,
                user: action.payload.user
            };
        default:
            return state;
    }
};
