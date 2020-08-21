import axios from 'axios'

const request = axios.create()

request.interceptors.response.use( response => response, () => {
  console.log(this)
  this.props.history.push('/login')
})

export default request