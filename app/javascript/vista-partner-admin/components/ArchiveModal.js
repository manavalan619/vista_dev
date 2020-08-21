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

const ArchiveModal = (props) => {
  return (
    <Modal isOpen={props.isOpen} toggle={props.toggle.bind(this)} >
      <ModalHeader>Archive {props.archiveItem}</ModalHeader>
      <Form onSubmit={props.onSubmit.bind(this)}>
        <ModalBody>
          {props.archiveText}
          {props.children}
        </ModalBody>
        <ModalFooter>
          <Button color="primary btn-fill" type='submit'>I'm sure</Button>
          <Button
            color="secondary btn-fill"
            onClick={props.toggle.bind(this)}>
            Cancel
          </Button>
        </ModalFooter>
      </Form>
    </Modal>
  )
}

export default ArchiveModal
