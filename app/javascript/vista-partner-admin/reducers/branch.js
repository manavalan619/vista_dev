import {
  ADD_BRANCH,
  ARCHIVE_BRANCH,
  UPDATE_BRANCH,
  UPDATE_BRANCH_LIST,
  FILL_BRANCH_LIST,
  VIEW_BRANCH,
  CHANGE_BRANCH_TAB
} from '../actions/actionTypes'

import _ from 'lodash'

const initialState = {
  branches: [],
  branchInFocus: {},
  branchTab:0
}

export default function branchReducer( state = initialState, action){

  switch (action.type){

  case UPDATE_BRANCH:{
    return {
      ...state,
      branchInFocus: action.message
    }
  }

  case ARCHIVE_BRANCH: {
    let { branches } = state
    return {
      ...state,
      branches: branches.filter(branch => {
        return branch.id !== parseInt(action.message, 10)
      })
    }
  }

  case CHANGE_BRANCH_TAB:{
    return {
      ...state,
      unitTab: action.message
    }
  }

  case ADD_BRANCH:{
    let updated = [].concat(state.branches, action.message)
    return {
      ...state,
      branches: updated,
    }
  }

  case FILL_BRANCH_LIST:{
    return {
      ...state,
      branches: action.message
    }
  }

  case UPDATE_BRANCH_LIST:{
    const { branches } = state
    const { message } = action
    let indexOfBranch = _.findIndex(branches, (obj) => obj.id === message.id)
    const newList = [].concat(branches.slice(0,indexOfBranch),message, branches.slice(indexOfBranch + 1))
    return {
      ...state,
      branches: newList
    }
  }

  default:{
    return state
  }
}
}
