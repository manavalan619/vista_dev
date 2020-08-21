import { PUSH_FLASH_MESSAGE, REMOVE_FLASH_MESSAGE } from '../actions/actionTypes'
import _ from 'lodash'
const initialState = { flashMessages:[]}

export default function flashMessageReducer(state= initialState, action){
  switch (action.type) {
    case PUSH_FLASH_MESSAGE: {
      action.message.index = Date.now()
      const updatedArray = [].concat(state.flashMessages, action.message)
      return {
          ...state,
          flashMessages: updatedArray
        }
    }
    case REMOVE_FLASH_MESSAGE: {
      return {
        ...state,
        flashMessages: state.flashMessages.filter( msg => msg.index !== action.message)
      }
    }
    default:
     return state
  }
}