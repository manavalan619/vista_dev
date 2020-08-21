import {
  CHANGE_TAB
} from '../actions/actionTypes'

const initialState = {
  currentTab: 0
}

export default function tabReducer( state = initialState, action){
  switch (action.type){

    case CHANGE_TAB:{
      console.log(action.message)
      return {
        ...state,
        currentTab: action.message
      }
    }
    default:{
      return state
    }
  }
}