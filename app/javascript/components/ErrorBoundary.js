import React, { Component } from 'react'

function withErrorBoundary(WrappedComponent) {
  return class extends Component {
    constructor(props) {
      super(props)
      this.state = { hasError: false }
    }

    componentDidCatch(error, errorInfo) {
      this.setState({ error, errorInfo })
    }

    render() {
      if (this.state.errorInfo) {
        return (
          <div className="card bg-light mb-3">
            <div className="card-header">Something went wrong</div>
            <div className="card-body">
              <details style={{ whiteSpace: 'pre-wrap' }}>
                {this.state.error && this.state.error.toString()}
                <br />
                {this.state.errorInfo.componentStack}
              </details>
            </div>
          </div>
        )
      }
      return <WrappedComponent {...this.props} />
    }
  }
}

export { withErrorBoundary }
