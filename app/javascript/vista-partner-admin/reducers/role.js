import {
  ADD_ROLE,
  VIEW_ROLE,
  UPDATE_ROLE,
  FILL_ROLE_LIST,
  ARCHIVE_ROLE,
} from '../actions/actionTypes'

const initialState = {
  roles: [],
  roleInFocus: {}
}

export default function roleReducer( state = initialState, action){

  switch (action.type){

  case UPDATE_ROLE:{
    return {
      ...state,
      roleInFocus: action.message
    }
  }

  case ARCHIVE_ROLE:{
    let { roles } = state
    return {
      ...state,
      roles: state.roles.filter(role => role.id !== action.message)
    }
  }

  case VIEW_ROLE:{
    return {
      ...state,
      roleInFocus: action.message
    }
  }

  case ADD_ROLE:{
    let updated = [].concat(state.roles, action.message)
    return {
      ...state,
      roles: updated,
    }
  }


  case FILL_ROLE_LIST:{
    return {
      ...state,
      roles: action.message
    }
  }

  default:{
    return state
  }
}
}
