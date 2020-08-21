# Partners

## Get all partners

```javascript
import Api from 'api'

Api.get('/partners').then(response => {
  const { data: partners } = response
})
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": 1,
    "name": "Park Hyatt New York",
    "about": "Across the street from Carnegie Hall, this sleek hotel in Midtown is a minute's walk from 57th Street subway station and a mile from the Lincoln Centre",
    "email": "",
    "latitude": 40.765605,
    "longitude": -73.97904,
    "categories": [
      "Hotels"
    ],
    "sharingProfile": false,
    "address": {
      "id": 43,
      "label": null,
      "line1": "153 W 57th St",
      "line2": "",
      "town": "New York",
      "county": "NY",
      "postcode": "10019",
      "country": "US",
      "phone": "",
      "latitude": "40.765605",
      "longitude": "-73.97904"
    },
    "photo": {
      "id": 57,
      "largeUrl": "https://some.url/some-photo.jpg",
      "mediumUrl": "https://some.url/some-photo.jpg",
      "squareUrl": "https://some.url/some-photo.jpg",
      "thumbUrl": "https://some.url/some-photo.jpg"
    }
  }
]
```

This endpoint retrieves all partners.

### HTTP Request

`GET https://api.getvista.co/v1/partners`

## Get a specific partner

```javascript
import Api from 'api'

const partnerId = 1

Api.get(`/partners/${partnerId}`).then(response => {
  const { data: partner } = response
})
```

> The above command returns JSON structured like this:

```json
{
  "id": 1,
  "name": "Cardiff Branch",
  "about": "Corrupti rem et eligendi. Aut enim sequi exercitationem ea temporibus sint voluptates. Rerum aspernatur et consequuntur ab.\nDolor quaerat id omnis natus vel numquam illo. Eveniet in reiciendis. Ut voluptatem quasi rerum recusandae rerum quia soluta. Voluptatem reprehenderit placeat voluptatum et numquam voluptatem.",
  "email": null,
  "latitude": 27.32901,
  "longitude": 176.722461,
  "categories": [],
  "sharingProfile": false,
  "address": {
    "id": 102,
    "label": "Hyatt, Tillman and Gislason",
    "line1": "473 Cullen Locks",
    "line2": "Apt. 472",
    "town": "Schroederville",
    "county": "Alaska",
    "postcode": "90782",
    "country": "Mongolia",
    "phone": "994.536.8307 x1632",
    "latitude": "27.32901",
    "longitude": "176.722461"
  },
  "photo": {
    "id": 97,
    "largeUrl": "https://some.url/some-photo.jpg",
    "mediumUrl": "https://some.url/some-photo.jpg",
    "squareUrl": "https://some.url/some-photo.jpg",
    "thumbUrl": "https://some.url/some-photo.jpg"
  }
}
```

This endpoint retrieves a specific partner.

### HTTP Request

`GET https://api.getvista.co/v1/partners/:id`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the partner to retrieve
