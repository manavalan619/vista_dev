# Me

## Get current user

> To get current user, use this code in the app:

```javascript
import Api from 'api'

Api.get('/me').then(response => {
  const { data: user } = response
})
```

> The above command returns JSON structured like this:

```json
{
  "id": 1,
  "email": "chris@kanso.io",
  "firstName": "Chris",
  "lastName": "Edwards",
  "name": "Chris Edwards",
  "jobTitle": "Developer",
  "company": "Kanso",
  "address": null,
  "memberId": "DnMZrZ",
  "updatedAt": "2017-10-10T13:45:05.089Z",
  "avatar": {
    "id": 1,
    "largeUrl": "https://some.url/some-photo.jpg",
    "mediumUrl": "https://some.url/some-photo.jpg",
    "squareUrl": "https://some.url/some-photo.jpg",
    "thumbUrl": "https://some.url/some-photo.jpg"
  }
}
```

You can get the current user based on the token in the header without passing any parameters.

### HTTP Request

`GET https://api.getvista.co/v1/me`

## Update current user

> To update current user, use this code in the app:

```javascript
import Api from 'api'

const params = {
  user: {
    firstName: 'New',
    lastName: 'Name'
  }
}

Api.put('/me', params).then(response => {
  const { data: user } = response
})
```

> The above command returns JSON structured like this:

```json
{
  "id": 1,
  "email": "chris@kanso.io",
  "firstName": "New",
  "lastName": "Name",
  "name": "New Name",
  "jobTitle": "Developer",
  "company": "Kanso",
  "address": null,
  "memberId": "DnMZrZ",
  "updatedAt": "2017-10-10T13:45:05.089Z",
  "avatar": {
    "id": 1,
    "largeUrl": "https://some.url/some-photo.jpg",
    "mediumUrl": "https://some.url/some-photo.jpg",
    "squareUrl": "https://some.url/some-photo.jpg",
    "thumbUrl": "https://some.url/some-photo.jpg"
  }
}
```

You can update the current user by sending a `PUT` or `PATCH` request with the new user details to `/me`.

### HTTP Request

`PUT https://api.getvista.co/v1/me`
