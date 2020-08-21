import { combineReducers } from 'redux'

import businessUnitReducer from './unit'
import partnerReducer from './partner'
import branchReducer from './branch'
import roleReducer from './role'
import chevronReducer from './chevron'
import tabReducer from './tab'
import staffReducer from './staff'
import flashMessageReducer from './flashMessage'

export default combineReducers({
  businessUnitReducer,
  partnerReducer,
  branchReducer,
  chevronReducer,
  roleReducer,
  tabReducer,
  staffReducer,
  flashMessageReducer
})
