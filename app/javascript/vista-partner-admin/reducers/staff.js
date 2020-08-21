import {
  SET_USER,
  SET_USER_TYPE,
  SET_ORGANISATION,
  LOGOUT_USER,
  FILL_STAFF_LIST,
  SUSPEND_STAFF_MEMBER,
  UNSUSPEND_STAFF_MEMBER,
  ARCHIVE_STAFF_MEMBER,
  UPDATE_STAFF_LIST
} from '../actions/actionTypes'

const initialState = {
  userToken: localStorage.getItem('token'),
  organisation: localStorage.getItem('organisation'),
  userType: localStorage.getItem('userType'),
  staffMembers: []
}

export default function staffReducer(state = initialState, action) {
  switch (action.type) {
    case ARCHIVE_STAFF_MEMBER: {
      return {
        ...state,
        staffMembers: state.staffMembers.filter(user => {
          return user.id !== action.message
        })
      }
    }
    case SUSPEND_STAFF_MEMBER: {
      return {
        ...state,
        staffMembers: state.staffMembers.map(user => {
          if (user.id === action.message.id) {
            return action.message
          }
          return user
        })
      }
    }
    case UNSUSPEND_STAFF_MEMBER: {
      return {
        ...state,
        staffMembers: state.staffMembers.map(user => {
          if (user.id === action.message.id) {
            return action.message
          }
          return user
        })
      }
    }

    case UPDATE_STAFF_LIST: {
      let updatedList = state.staffMembers.map( staff => {
        if(staff.id === action.message.id){
          staff.roles = action.message.roles
        }
        return staff

      })
      return {
        ...state,
        staffMembers: updatedList
      }
    }
    case SET_USER: {
      return {
        ...state,
        userToken: action.message
      }
    }
    case SET_USER_TYPE: {
      return {
        ...state,
        userType: action.message
      }
    }
    case SET_ORGANISATION: {
      return {
        ...state,
        organisation: action.message
      }
    }
    case LOGOUT_USER: {
      return {
        ...state,
        userToken: null
      }
    }

    case FILL_STAFF_LIST: {
      return {
        ...state,
        staffMembers: action.message
      }
    }

    default:{
      return state
    }
  }
}
