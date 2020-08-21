# Authentication

## Login

> To login, use this code in the app:

```javascript
import Api from 'api'

const email = 'test@test.com'
const password = 'password'

Api.post('/login', { email, password }).then(response => {
  const { data: { token, needsOnboarding } } = response
})
```

> The above command returns JSON structured like this:

```json
{
  "token": "abc123",
  "needsOnBoarding": true|false
}
```

User's login with their email and password.

### HTTP Request

`POST https://api.getvista.co/v1/login`

## Registration

> To register, use this code in the app:

```javascript
import Api from 'api'

const email = 'test@test.com'
const password = 'password'

Api.post('/register', { email, password }).then(response => {
  const { data: { token, needsOnboarding } } = response
})
```

> The above command returns JSON structured like this:

```json
{
  "token": "abc123",
  "needsOnBoarding": true|false
}
```

User's register with their email and password.

### HTTP Request

`POST https://api.getvista.co/v1/register`

## Trigger password reset

> To send a password reset email, use this code in the app:

```javascript
import Api from 'api'

const email = 'test@test.com'

Api.post('/password/reset', { email }).then(response => {
  const { data } = response
}).catch((error) => {
  Api.handleError(error)
})
```

> The above command returns JSON structured like this:

```json
{
  "success": "Password reset email sent"
}
```

Trigger a password reset email to be sent to the user.

### HTTP Request

`POST https://api.getvista.co/v1/password/reset`

## Set new password

> To set a new password, use this code in the app:

```javascript
import Api from 'api'

const token = 'abc123'
const password = 'password'
const passwordConfirmation = 'password'

Api.put('/password/reset', { token, password, passwordConfirmation }).then(response => {
  const { data } = response
}).catch((error) => {
  Api.handleError(error)
})
```

> The above command returns JSON structured like this:

```json
{
  "success": "Password successfully reset"
}
```

Update the user's password using the token sent in the email triggered by the password reset. The request can be a `PUT` or `PATCH`.

### HTTP Request

`PUT https://api.getvista.co/v1/password/reset`

## Authentication

Vista expects a token to be included in all API requests to the server in a header that looks like the following:

`Authorization: Token token=abc123`

<aside class="notice">
You must replace <code>abc123</code> with the API token returned from the login endpoint.
</aside>
