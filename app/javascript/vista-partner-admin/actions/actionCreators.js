import * as types from './actionTypes'

export const archiveStaffMember = (staffMember) => {
  return {
    type: types.ARCHIVE_STAFF_MEMBER,
    message: staffMember
  }
}

export const suspendStaffMember = (staffMember) => {
  return {
    type: types.SUSPEND_STAFF_MEMBER,
    message: staffMember
  }
}

export const updateStaffList = (staffMember) => {
  return {
    type: types.UPDATE_STAFF_LIST,
    message: staffMember
  }
}

export const unsuspendStaffMember = (staffMember) => {
  return {
    type: types.UNSUSPEND_STAFF_MEMBER,
    message: staffMember
  }
}

export const addUnit = (unit)=> {
  return {
    type: types.ADD_UNIT,
    message: unit
  }
}

export const removePartner = (partner) => {
  return {
    type: types.REMOVE_PARTNER,
    message: partner
  }
}

export const addRole = (role) => {
  return {
    type: types.ADD_ROLE,
    message: role
  }
}

export const viewRole = (role) => {
  return {
    type: types.VIEW_ROLE,
    message: role
  }
}

export const updateRole = (updatedRole) => {
  return {
    type: types.UPDATE_ROLE,
    message: updatedRole
  }
}

export const archiveRole = (id) => {
  return {
    type: types.ARCHIVE_ROLE,
    message: id
  }
}

export const fillRoleList = ( roleArray ) => {
  return {
    type: types.FILL_ROLE_LIST,
    message: roleArray
  }
}

export const addBranch = (branch) => {
  return {
    type: types.ADD_BRANCH,
    message: branch
  }
}

export const fillUnitList = (unitArray) => {
  return {
    type: types.FILL_UNIT_LIST,
    message: unitArray
  }
}

export const fillBranchList = (branchArray) => {
  return {
    type: types.FILL_BRANCH_LIST,
    message: branchArray
  }
}

export const viewUnit = (selectedUnit) => {
  return {
    type: types.VIEW_UNIT,
    message: selectedUnit
  }
}

export const updateBranch = (updatedBranch) => {
  return {
    type: types.UPDATE_BRANCH,
    message: updatedBranch
  }
}

export const addPartner = (partner) => {
  return {
    type: types.ADD_PARTNER,
    message: partner
  }
}

export const updatePartner = ( updatedPartner) => {
  return {
    type: types.UPDATE_PARTNER,
    message: updatedPartner
  }
}

export const archiveBranch = (branch) => {
  return {
    type: types.ARCHIVE_BRANCH,
    message: branch
  }
}

export const viewPartner = (partner) => {
  return {
    type: types.VIEW_PARTNER,
    message: partner
  }
}

export const archiveUnit = (unit) => {
  return {
    type: types.ARCHIVE_UNIT,
    message: unit
  }
}

export const fillPartnerList = (partners) => {
  return {
    type: types.FILL_PARTNER_LIST,
    message: partners
  }
}

export const fillStaffList = (staffMembers) => {
  return {
    type: types.FILL_STAFF_LIST,
    message: staffMembers
  }
}

export const changeUnitTab = (tab) => {
  return {
    type: types.CHANGE_UNIT_TAB,
    message: tab
  }
}

export const changeBranchTab = (tab) => {
  return {
    type: types.CHANGE_BRANCH_TAB,
    message: tab
  }
}

export const changeTab = (tab) => {
  console.log(tab)
  return {
    type: types.CHANGE_TAB,
    message: tab
  }
}

export const updateUnit = (updatedUnit ) => {
  return {
    type: types.UPDATE_UNIT,
    message: updatedUnit
  }
}

export const updateUnitList = (updatedUnit) => {
  return {
    type: types.UPDATE_UNIT_LIST,
    message: updatedUnit
  }
}

export const updateBranchList = (updatedBranch) => {
  return {
    type: types.UPDATE_BRANCH_LIST,
    message: updatedBranch
  }
}

export const changeOpenChevron = (chevron) => {
  return {
    type: types.CHANGE_OPEN_CHEVRON,
    message: chevron
  }
}

export const registerItemsLoaded = (chevron) => {
  return {
    type: types.REGISTER_ITEMS_LOADED,
    message: chevron
  }
}

export const setUser = (userToken) => {
  return {
    type: types.SET_USER,
    message: userToken
  }
}

export const setOrganisation = (organisation) => {
  return {
    type: types.SET_ORGANISATION,
    message: organisation
  }
}

export const setUserType = (userType) => {
  return {
    type: types.SET_USER_TYPE,
    message: userType
  }
}

export const logoutUser = (userToken) => {
  return {
    type: types.LOGOUT_USER,
    message: userToken
  }
}

export const pushFlashMessage = (message) => {
  return {
    type: types.PUSH_FLASH_MESSAGE,
    message: message
  }
}

export const removeFlashMessage = (message) => {
  return {
    type: types.REMOVE_FLASH_MESSAGE,
    message: message
  }
}
