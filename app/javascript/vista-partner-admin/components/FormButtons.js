import React from 'react'
import { Button } from 'reactstrap'

const FormButtons = (props) => {
  const buttons = []
  buttons.push(
    <Button
      key='add'
      color="primary"
      className="btn-fill"
      type='submit'>
      {props.isEditing ? 'Save' : 'Add' }
    </Button>
  )
  if (props.isEditing && props.userType === 'Admin') {
    buttons.push(
      <Button key='archive' color="danger btn-fill" onClick={props.onArchive}>
        Archive
      </Button>
    )
  }
  buttons.push(
    <Button key='cancel' color="secondary btn-fill" onClick={props.resetForm.bind(this)}>
      Cancel
    </Button>
  )
  return (
    <div className='button-container'>
      {buttons}
    </div>
  )
}

export default FormButtons
