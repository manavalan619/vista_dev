import { isEmail, isAlpha, isMobilePhone, isByteLength, isAscii, isURL } from 'validator'

const FORENAME = { MIN: 2, MAX: 15}
const SURNAME = { MIN: 2, MAX:20 }
const BRANCH_NAME = { MIN: 3, MAX:30 }
const UNIT_NAME = { MIN: 3, MAX: 30 }
const ROLE_NAME = { MIN: 3, MAX: 25 }
const PASSWORD = { MIN: 8, MAX: 20 }

export const partnerForm = (fields) => {
  const { email, first_name, last_name, password, mobile_number } = fields
  const errors = []
  if (!checkEmail(email.value)) errors.push({ email: 'Email must be in a valid email format'})
  if (!checkNameField(first_name.value, FORENAME.MIN, FORENAME.MAX)) errors.push({
    first_name:`Forename must be between ${FORENAME.MIN} and ${FORENAME.MAX} letters long`
  })
  if (!checkNameField(last_name.value, SURNAME.MIN, SURNAME.MAX)) errors.push({
    last_name:`Surname must be between ${SURNAME.MIN} and ${SURNAME.MAX} letters long`
  })
  if (!checkPassword(password.value)) errors.push({ password: `Password must be at least ${PASSWORD.MIN} characters long`})
  // if (!checkMobileNumber(mobile_number.value)) errors.push({ mobile_number:'Mobile must be a valid email' })
  return !errors.length || errors
}

export const branchForm = (fields) => {
  const { name, image } = fields;
  const errors =[]
  if (!checkBranchName(name.value, BRANCH_NAME.MIN, BRANCH_NAME.MAX)) errors.push({
    name: `Branch name must be between ${BRANCH_NAME.MIN} and ${BRANCH_NAME.MAX} letters long`
  })
  if (!checkImageUrl(image.value)) errors.push ({image: `Image field must contain a valid url`})
  return !errors.length || errors
}

export const unitForm = (fields) => {
  const { name } = fields;
  const errors =[]
  if (!checkUnitName(name.value, UNIT_NAME.MIN, UNIT_NAME.MAX)) errors.push({
    name: `Unit name must be between ${UNIT_NAME.MIN} and ${UNIT_NAME.MAX} letters long`
  })
  return !errors.length || errors
}

export const staffForm = (fields, currentUser) => {

  const { pin1, pin2, type, email, mobile_number, unit, branch } = fields
  console.log('Branch', branch)
  console.log('Unit', unit)
  const errors = []
  if (!checkNameField(first_name.value, FORENAME.MIN, FORENAME.MAX)) errors.push({
    first_name:`Forename must be between ${FORENAME.MIN} and ${FORENAME.MAX} letters long`
  })
  if (currentUser !== 'BranchManager'){
    if (!unit.value ) errors.push({ unit: 'The staff member must belong to a unit'})
    if (!branch.value ) errors.push({ branch: 'The staff member must belong to a branch'})
  }
  if (!checkNameField(last_name.value, SURNAME.MIN, SURNAME.MAX)) errors.push({
    last_name:`Surname must be between ${SURNAME.MIN} and ${SURNAME.MAX} letters long`
  })
  // TODO: probably better to actually give this a value
  if (type && (type.value === 'StaffMember') || currentUser === "BranchManager") {
    if (!checkPin(pin1.value)) errors.push({pin1: 'Pin must be a four digit number'})
    if (pin1.value !== pin2.value) errors.push({pin2: 'Pins must match'})
    if (email.value){
      if (!checkEmail(email.value)) errors.push({ email: 'Email must be in a valid email format'})
    }
  }else {
    if (!checkEmail(email.value)) errors.push({ email: 'Email must be in a valid email format'})
  }
  if (!checkMobileNumber(mobile_number.value)) errors.push({ mobile_number:'Mobile must be a valid phone number' })

  return !errors.length || errors
}

export const roleForm = (fields) => {
  const { name } = fields
  const errors = []
  if (!checkRoleName(name.value, ROLE_NAME.MIN, ROLE_NAME.MAX)) errors.push({
    name: `Role name must be between ${ROLE_NAME.MIN} and ${ROLE_NAME.MAX} letters long`
  })
  return !errors.length || errors
}

export const passwordForm = (fields) => {
  const { password, password_confirmation } = fields
  const errors = []
  if (!checkPassword(password.value)) errors.push({ password: `Password must be at least ${PASSWORD.MIN} characters long`})
  if (password.value !== password_confirmation.value ) errors.push({ password_confirmation: `Passwords need to match`})
  return !errors || errors
}

export const emailCheck = (fields) => {
  const { email } = fields
  const errors = []
  if (!checkEmail(email.value)) errors.push({ email: 'Email must be in a valid email format'})
  return !errors || errors
}

function checkPin(pin){
  let characterArray = pin.split('')
  if (characterArray.length > 4 || !characterArray.length) return false
  let valid = characterArray.every((num) =>  num > 0 && num < 9 )
  return valid
}

function checkImageUrl(string){
  return isURL(string) || string === ''
}

function checkEmail(email){
  return isEmail(email)
}

function checkUnitName(name, min, max){
  return checkBranchName(name, min, max)
}

function checkRoleName(name, min, max){
  return checkBranchName(name, min, max)
}

function checkPassword(password){
  return isByteLength(password,{ min: PASSWORD.MIN })
}

function checkBranchName(name, min, max){
  return isAscii( name, min, max) && isByteLength(name, {min, max})
}

function checkNameField(name, min, max){
  return isAlpha(name, 'en-GB') && isByteLength(name, { min , max})
}

function checkMobileNumber(number){
  return isMobilePhone(number,'en-GB') || isMobilePhone(number,'en-US')
}
