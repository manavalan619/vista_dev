import React, { Component } from 'react'
import { Alert } from 'reactstrap'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as actions from '../actions/actionCreators'

const styles = {
  alertBox: {
    position: 'fixed',
    bottom: '30px',
    right: '30px'
  }
}



class FlashMessage extends Component{

  toggle(id, evt){
    this.props.actions.removeFlashMessage(id)
  }

  renderFlashMessages(){
    return this.props.flashMessages.map( message => {
      setTimeout(()=>{ this.toggle.call(this,message.index )},5000)
      return (
        <Alert
          isOpen={true}
          toggle={this.toggle.bind(this, message.index)}
          key={message.index}
          color={message.color}
        >{message.text}
        </Alert>
      )
    })
  }

  render(){
    if (!this.props.flashMessages.length) return null
    return(
      <div style={styles.alertBox}>
        {this.renderFlashMessages.call(this)}
      </div>
    )
  }
}

function mapStateToProps(state){
  return {
    flashMessages: state.flashMessageReducer.flashMessages
  }
}

function mapDispatchToProps(dispatch){
  return {
    actions: bindActionCreators(actions, dispatch)
  }
}

export default connect(mapStateToProps,mapDispatchToProps)(FlashMessage)