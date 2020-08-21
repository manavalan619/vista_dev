import {
  ADD_PARTNER,
  FILL_PARTNER_LIST,
  VIEW_PARTNER,
  UPDATE_PARTNER,
  REMOVE_PARTNER
} from '../actions/actionTypes'


const initialState = {
  partnerList: [],
  partnerInFocus: {}
}

export default function partnerReducer( state = initialState, action){
  switch (action.type){

  case ADD_PARTNER:{
    let updated = [].concat(state.partnerList,action.message)

    return {
      ...state,
      partnerList: updated
    }
  }

  case VIEW_PARTNER: {
    return {
      ...state,
      partnerInFocus: action.message
    }
  }

  case UPDATE_PARTNER:{
    return {
      ...state,
      partnerInFocus: action.message
    }
  }

  case REMOVE_PARTNER:{
    let { partnerList } = state
    let indexToRemove = partnerList.findIndex((obj)=> {
      return obj._id === action.message._id
    })
    let updated = [].concat(partnerList.slice(0,indexToRemove),action.message, partnerList.slice(indexToRemove + 1))
    return {
      ...state,
      partnerList: updated
    }
  }

  case FILL_PARTNER_LIST:{
    return {
      ...state,
      partnerList: action.message
    }
  }

  default:{
    return state
  }
}
}