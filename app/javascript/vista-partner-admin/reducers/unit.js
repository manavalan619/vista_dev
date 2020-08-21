import {
  ADD_UNIT,
  FILL_UNIT_LIST,
  VIEW_UNIT,
  ARCHIVE_UNIT,
  UPDATE_UNIT,
  UPDATE_UNIT_LIST,
  CHANGE_UNIT_TAB
} from '../actions/actionTypes'

import _ from 'lodash'

const initialState = {
  businessUnits: [],
  unitInFocus: {},
  unitTab: 0
}

export default function businessUnitReducer( state = initialState, action){
  switch (action.type){

    case FILL_UNIT_LIST:{
      return {
        ...state,
        businessUnits: action.message
      }
    }

    case CHANGE_UNIT_TAB:{
      return {
        ...state,
        unitTab: action.message
      }
    }

    case ADD_UNIT:{
      let updated = [].concat(state.businessUnits, action.message)
      return {
        ...state,
        businessUnits: updated,
        unitInFocus: action.message
      }
    }

    case VIEW_UNIT:{
      return {
        ...state,
        businessUnit: action.message
      }
    }

    case ARCHIVE_UNIT:{
      let { businessUnits } = state

      return {
        ...state,
        businessUnits: businessUnits.filter(unit => {
          return unit.id !== action.message
        })
      }
    }

    case UPDATE_UNIT:{
      return {
        ...state,
        unitInFocus: action.message
      }
    }

    case UPDATE_UNIT_LIST:{
      const { businessUnits } = state
      const { message } = action
      let indexOfUnit = _.findIndex(businessUnits, (obj) => obj.id === message.id)
      const newList = [].concat(businessUnits.slice(0,indexOfUnit),message, businessUnits.slice(indexOfUnit + 1))
      return {
        ...state,
        businessUnits: newList
      }
    }

    default:
      return state
  }
}
