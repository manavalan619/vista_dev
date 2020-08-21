# Profile sharing

## Sharing profile

```javascript
import Api from 'api'

const partnerId = 1

Api.post(`/partners/${partnerId}/share`).then(response => {
  // response will be blank
}).catch((error) => {
  Api.handleError(error)
})
```

> The above command returns a blank response if successful.

This endpoint shares the current user's profile with a partner.

### HTTP Request

`POST https://api.getvista.co/v1/partners/:id/share`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the partner to share with

## Revoke sharing profile

```javascript
import Api from 'api'

const partnerId = 1

Api.delete(`/partners/${partnerId}/revoke`).then(response => {
  // response will be blank
}).catch((error) => {
  Api.handleError(error)
})
```

> The above command returns a blank response if successful.

This endpoint revokes sharing the current users' profile with a partner.

### HTTP Request

`DELETE https://api.getvista.co/v1/partners/:id/revoke`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the partner to share with

## Revoke all profile shares

```javascript
import Api from 'api'

Api.post(`/partners/revoke`).then(response => {
  // response will be blank
}).catch((error) => {
  Api.handleError(error)
})
```

> The above command returns a blank response if successful.

This endpoint revokes sharing the current user's profile with all partners.

### HTTP Request

`DELETE https://api.getvista.co/v1/partners/revoke`
