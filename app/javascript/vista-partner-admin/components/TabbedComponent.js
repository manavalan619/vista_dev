import React, { Component } from 'react'
import { TabContent, TabPane, Nav, NavItem, NavLink, Card, Button, CardText, Row, Col, CardHeader } from 'reactstrap';
import classnames from 'classnames'

let style = {
  navItem: {
    flex: 1,
    textAlign: 'center'
  }
}


export default class TabbedComponent extends React.Component {
  constructor(props) {
    super(props);
    this.toggle = this.toggle.bind(this);
  }

  toggle(tab) {
    if (this.props.currentTab !== tab) {
      this.props.changeTab(tab)
    }
  }

  renderTabs(){
    return this.props.children.map((pane, index) => {
      return <TabPane key={this.props.tabs[index]} tabId={index}><Row><Col sm="12">{pane}</Col></Row></TabPane>
    })
  }

  renderTabLinks(){
    return this.props.children.map((tab, index) => {
      return (
        <NavItem style={style.navItem} key={this.props.tabs[index]} >
          <NavLink
            className={classnames({ active: this.props.currentTab === index })}
            onClick={ () => this.toggle(index)}
          >
            {this.props.tabs[index]}
          </NavLink>
        </NavItem>
      )
    })
  }

  render() {
    return (
      <Card>
        <CardHeader>
          <Nav tabs className='card-header-tabs'>
            { this.renderTabLinks.call(this)}
          </Nav>
        </CardHeader>
        <div className='content'>
          <TabContent activeTab={this.props.currentTab} style={style.tabContent}>
            {this.renderTabs.call(this)}
          </TabContent>
        </div>
      </Card>
    )
  }
}
