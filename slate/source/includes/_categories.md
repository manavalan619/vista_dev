# Categories

## Get all categories

```javascript
import Api from 'api'

Api.get(`/categories`).then(response => {
  const { data: categories } = response
}).catch((error) => {
  Api.handleError(error)
})
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": 4222,
    "title": "General",
    "description": "Maecenas faucibus mollis interdum. Nulla vitae elit libero, a pharetra augue. Nulla vitae elit libero, a pharetra augue. Aenean lacinia bibendum nulla sed consectetur. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Cras mattis consectetur purus sit amet fermentum.",
    "parentId": 4211,
    "hasChildren": false,
    "ancestry": "4211",
    "subtreeQuestionsCount": 6,
    "ignored": false,
    "position": 1,
    "initial": false,
    "visibilityConditions": null,
    "photo": {
      "id": 4107,
      "largeUrl": "https://some.url/some-photo.jpg",
      "mediumUrl": "https://some.url/some-photo.jpg",
      "squareUrl": "https://some.url/some-photo.jpg",
      "thumbUrl": "https://some.url/some-photo.jpg"
    }
  },
  {
    "id": 4213,
    "title": "Parking",
    "description": "Maecenas faucibus mollis interdum. Nulla vitae elit libero, a pharetra augue. Nulla vitae elit libero, a pharetra augue. Aenean lacinia bibendum nulla sed consectetur. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Cras mattis consectetur purus sit amet fermentum.",
    "parentId": 4211,
    "hasChildren": false,
    "ancestry": "4211",
    "subtreeQuestionsCount": 2,
    "ignored": false,
    "position": 2,
    "initial": false,
    "visibilityConditions": null,
    "photo": {
      "id": 4104,
      "largeUrl": "https://some.url/some-photo.jpg",
      "mediumUrl": "https://some.url/some-photo.jpg",
      "squareUrl": "https://some.url/some-photo.jpg",
      "thumbUrl": "https://some.url/some-photo.jpg"
    }
  },
  {
    "id": 4212,
    "title": "Facilities",
    "description": "Maecenas faucibus mollis interdum. Nulla vitae elit libero, a pharetra augue. Nulla vitae elit libero, a pharetra augue. Aenean lacinia bibendum nulla sed consectetur. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Cras mattis consectetur purus sit amet fermentum.",
    "parentId": 4211,
    "hasChildren": false,
    "ancestry": "4211",
    "subtreeQuestionsCount": 9,
    "ignored": false,
    "position": 3,
    "initial": false,
    "visibilityConditions": [
      {
        "questionId": 27,
        "answer": "Reception area"
      }
    ],
    "photo": {
      "id": 4103,
      "largeUrl": "https://some.url/some-photo.jpg",
      "mediumUrl": "https://some.url/some-photo.jpg",
      "squareUrl": "https://some.url/some-photo.jpg",
      "thumbUrl": "https://some.url/some-photo.jpg"
    }
  },
  {
    "id": 4214,
    "title": "Budget",
    "description": "Maecenas faucibus mollis interdum. Nulla vitae elit libero, a pharetra augue. Nulla vitae elit libero, a pharetra augue. Aenean lacinia bibendum nulla sed consectetur. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Cras mattis consectetur purus sit amet fermentum.",
    "parentId": 4211,
    "hasChildren": false,
    "ancestry": "4211",
    "subtreeQuestionsCount": 1,
    "ignored": false,
    "position": 4,
    "initial": false,
    "visibilityConditions": null,
    "photo": {
      "id": 4105,
      "largeUrl": "https://some.url/some-photo.jpg",
      "mediumUrl": "https://some.url/some-photo.jpg",
      "squareUrl": "https://some.url/some-photo.jpg",
      "thumbUrl": "https://some.url/some-photo.jpg"
    }
  },
  {
    "id": 4224,
    "title": "General",
    "description": "",
    "parentId": 4223,
    "hasChildren": false,
    "ancestry": "4223",
    "subtreeQuestionsCount": 7,
    "ignored": false,
    "position": 5,
    "initial": false,
    "visibilityConditions": null,
    "photo": null
  },
  {
    "id": 4215,
    "title": "Room",
    "description": "Maecenas faucibus mollis interdum. Nulla vitae elit libero, a pharetra augue. Nulla vitae elit libero, a pharetra augue. Aenean lacinia bibendum nulla sed consectetur. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Cras mattis consectetur purus sit amet fermentum.",
    "parentId": 4211,
    "hasChildren": false,
    "ancestry": "4211",
    "subtreeQuestionsCount": 6,
    "ignored": false,
    "position": 5,
    "initial": false,
    "visibilityConditions": null,
    "photo": {
      "id": 4106,
      "largeUrl": "https://some.url/some-photo.jpg",
      "mediumUrl": "https://some.url/some-photo.jpg",
      "squareUrl": "https://some.url/some-photo.jpg",
      "thumbUrl": "https://some.url/some-photo.jpg"
    }
  },
  {
    "id": 4219,
    "title": "Banking",
    "description": "Suscipit aspernatur deleniti enim odio aliquam. Nobis aliquid dolorum eligendi culpa delectus perferendis odit. Molestias optio vitae. Libero praesentium error accusantium vel maiores. Sapiente illum quos ullam facilis dolorem.",
    "parentId": null,
    "hasChildren": false,
    "ancestry": null,
    "subtreeQuestionsCount": 0,
    "ignored": false,
    "position": 234,
    "initial": false,
    "visibilityConditions": null,
    "photo": null
  },
  {
    "id": 4211,
    "title": "Hotel",
    "description": "Maecenas faucibus mollis interdum. Nulla vitae elit libero, a pharetra augue. Nulla vitae elit libero, a pharetra augue. Aenean lacinia bibendum nulla sed consectetur. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Cras mattis consectetur purus sit amet fermentum.",
    "parentId": null,
    "hasChildren": true,
    "ancestry": null,
    "subtreeQuestionsCount": 24,
    "ignored": false,
    "position": 235,
    "initial": true,
    "visibilityConditions": null,
    "photo": {
      "id": 4102,
      "largeUrl": "https://some.url/some-photo.jpg",
      "mediumUrl": "https://some.url/some-photo.jpg",
      "squareUrl": "https://some.url/some-photo.jpg",
      "thumbUrl": "https://some.url/some-photo.jpgg"
    }
  },
  {
    "id": 4223,
    "title": "Lifestyle",
    "description": "",
    "parentId": null,
    "hasChildren": true,
    "ancestry": null,
    "subtreeQuestionsCount": 7,
    "ignored": false,
    "position": 236,
    "initial": false,
    "visibilityConditions": null,
    "photo": null
  },
  {
    "id": 4216,
    "title": "Government",
    "description": "Dolores dolor enim provident rerum. Voluptas consequatur similique deserunt delectus praesentium. Totam reprehenderit dolorem reiciendis consequatur magni quisquam. Expedita velit maxime.",
    "parentId": null,
    "hasChildren": false,
    "ancestry": null,
    "subtreeQuestionsCount": 0,
    "ignored": false,
    "position": 237,
    "initial": false,
    "visibilityConditions": null,
    "photo": null
  },
  {
    "id": 4218,
    "title": "Hospitality",
    "description": "Voluptatibus enim expedita et et molestiae sit. Qui ea consequatur dolore sed nesciunt quia. Nemo eum soluta dolores facilis quam hic ad. Explicabo non cumque et odit aut veritatis.",
    "parentId": null,
    "hasChildren": false,
    "ancestry": null,
    "subtreeQuestionsCount": 0,
    "ignored": false,
    "position": 238,
    "initial": false,
    "visibilityConditions": null,
    "photo": null
  },
  {
    "id": 4217,
    "title": "Farming",
    "description": "Dolore incidunt repudiandae libero rerum sed est et. Possimus consequuntur quaerat labore voluptas maxime iusto fugit. Minus quis qui. Tempora omnis totam optio nihil incidunt consectetur eum. Corporis voluptatem suscipit quia nam.",
    "parentId": null,
    "hasChildren": false,
    "ancestry": null,
    "subtreeQuestionsCount": 0,
    "ignored": false,
    "position": 239,
    "initial": false,
    "visibilityConditions": null,
    "photo": null
  }
]
```

This endpoint gets all categories.

### HTTP Request

`GET https://api.getvista.co/v1/categories`

## Ignore / disable a category

```javascript
import Api from 'api'

const categoryId = 1

Api.post(`/categories/${categoryId}/ignore`).then(response => {
  // response will be blank
}).catch((error) => {
  Api.handleError(error)
})
```

> The above command returns a blank response if successful.

This endpoint ignores / disables a category from showing in the app.

### HTTP Request

`POST https://api.getvista.co/v1/categories/:id/ignore`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the category to disable

## Re-enable a category

```javascript
import Api from 'api'

const categoryId = 1

Api.delete(`/categories/${categoryId}/ignore`).then(response => {
  // response will be blank
}).catch((error) => {
  Api.handleError(error)
})
```

> The above command returns a blank response if successful.

This endpoint re-enables a category in the app.

### HTTP Request

`DELETE https://api.getvista.co/v1/categories/:id/ignore`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the category to re-enable
