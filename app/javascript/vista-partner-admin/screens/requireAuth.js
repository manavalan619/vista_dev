import React from 'react'
import { withRouter } from 'react-router'
import { Link } from 'react-router-dom'
import axios from 'axios'
import { Container, Breadcrumb, BreadcrumbItem } from 'reactstrap'

export default function requireAuth(Component) {
  class AuthenticatedComponent extends React.Component {
    constructor(props) {
      super(props)
      this.state = { breadcrumbs: [] }
    }

    componentWillMount() {
      axios.interceptors.response.use( response => response, (err) => {
        if (err.response.status === 403){
          this.props.history.push('/login')
        }
      })
      this.checkAuth()
    }

    componentDidUpdate(){
      // this is to make the breadcrumbs transition nicely to visible
      let breadcrumbItems = document.querySelectorAll('.breadcrumb-item')
      setTimeout(function(){
        breadcrumbItems.forEach((crumb)=> crumb.classList.add('showbreadcrumb'))
      },0)
    }

    checkAuth() {
      const { history, location: { pathname, search } } = this.props
      const isLoggedIn = localStorage.getItem('token')
      if (!isLoggedIn) {
        const redirect = pathname + search
        history.push(`/login?redirect=${redirect}`)
      }
    }

    updateBreadcrumbs = (breadcrumbs) => {
      this.setState({ breadcrumbs })
    }

    renderBreadcrumbs(){
      const { breadcrumbs } = this.state
      if (!this.props.location.pathname.startsWith('/units')) return null
      return (
        <Container fluid>
          <Breadcrumb >
            {breadcrumbs.map((crumb, idx) => {
              const active = idx === breadcrumbs.length - 1
              return (
                <BreadcrumbItem  key={`breadcrumb${idx}`} active={active}>
                  {(active || !crumb.path) ? crumb.title : <Link to={crumb.path} >{crumb.title}</Link>}
                </BreadcrumbItem>
              )
            })}
          </Breadcrumb>
        </Container>
      )
    }

    render() {
      if (!localStorage.getItem('token')) {
        return null
      }
      return (
        <div>
         { this.renderBreadcrumbs.call(this) }
          <Component updateBreadcrumbs={this.updateBreadcrumbs} { ...this.props } />
        </div>
      )
    }
  }

  return withRouter(AuthenticatedComponent)
}
