
import { CHANGE_OPEN_CHEVRON, REGISTER_ITEMS_LOADED } from '../actions/actionTypes'

const initialState = { openChevron: null, loadedChevron: null }

export default function chevronReducer(state= initialState, action){
  switch (action.type) {
    case CHANGE_OPEN_CHEVRON: {
      return {
          ...state,
          openChevron: action.message,
          loadedChevron: null
        }
    }
    case REGISTER_ITEMS_LOADED: {
      return {
        ...state,
        loadedChevron: action.message
      }
    }
    default:
     return state
  }
}