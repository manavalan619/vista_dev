import React, { Component } from 'react'
import {
  Button,
  Form,
  FormGroup,
  Label,
  Input,
  Modal,
  ModalHeader,
  ModalBody,
  ModalFooter,
} from 'reactstrap'

const renderValidationError = (props, field)=>{
  if (!props.validationErrors || !props.validationErrors.length) return null
  let error = props.validationErrors.find(error => {
    return error.hasOwnProperty(field)
  })
  if (error) return (
    <small
      style={{color: 'red'}}
      className='float-right'
    >{error[field]}
    </small>
  )
}


const renderInputFields = (props) => {
  const { mapFieldsToHeader, formFields } = props.unitFieldCtrl
  return (
    formFields.map( field => {
      return (
        <FormGroup key={field.name}>
          <Label for={field.id}>{mapFieldsToHeader[field.name]}</Label>
          <Input
            autoComplete='off'
            type={field.type}
            name={field.name}
            id={field.id}
            placeholder={field.placeholder}
          />
          { renderValidationError(props, field.name) }
        </FormGroup>
      )
    })
  )
}

const FormModal = (props) => {
  return (
    <Modal isOpen={props.isOpen} toggle={props.toggle} className={props.className}>
      <ModalHeader toggle={props.toggle}>Create a {props.modalType}</ModalHeader>
      <Form onSubmit={props.onAdd}>
        <ModalBody>
            { renderInputFields(props)}
        </ModalBody>
        <ModalFooter style={{justifyContent: 'flex-start'}}>
          <Button color="primary btn-fill" type='submit'>Add</Button>
          <Button color="secondary btn-fill" onClick={props.toggle}>Cancel</Button>
        </ModalFooter>
      </Form>
    </Modal>
  )
}

export default FormModal
