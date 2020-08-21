# Syncing

## Get server information

```javascript
import Api from 'api'

Api.get(`/sync`).then(response => {
  const { data } = response
}).catch((error) => {
  Api.handleError(error)
})
```

> The above command returns JSON structured like this:

```json
{
  "answers": [
    {
      "questionId": 23,
      "updatedAt": "2017-09-19T15:33:00.033Z"
    },
    {
      "questionId": 25,
      "updatedAt": "2017-09-20T12:13:44.437Z"
    },
    {
      "questionId": 34,
      "updatedAt": "2017-09-20T12:17:08.956Z"
    },
    {
      "questionId": 26,
      "updatedAt": "2017-09-20T12:18:19.558Z"
    },
    {
      "questionId": 36,
      "updatedAt": "2017-09-20T12:29:00.676Z"
    },
    {
      "questionId": 27,
      "updatedAt": "2017-09-22T11:58:21.974Z"
    },
    {
      "questionId": 28,
      "updatedAt": "2017-09-22T11:59:07.897Z"
    },
    {
      "questionId": 30,
      "updatedAt": "2017-09-22T11:59:12.029Z"
    },
    {
      "questionId": 32,
      "updatedAt": "2017-09-22T11:59:18.110Z"
    },
    {
      "questionId": 29,
      "updatedAt": "2017-09-22T12:00:01.611Z"
    },
    {
      "questionId": 33,
      "updatedAt": "2017-09-22T12:00:15.490Z"
    },
    {
      "questionId": 31,
      "updatedAt": "2017-09-22T12:00:24.099Z"
    },
    {
      "questionId": 35,
      "updatedAt": "2017-09-22T12:15:22.340Z"
    },
    {
      "questionId": 19,
      "updatedAt": "2017-09-22T12:35:47.546Z"
    },
    {
      "questionId": 20,
      "updatedAt": "2017-09-22T12:35:50.356Z"
    },
    {
      "questionId": 21,
      "updatedAt": "2017-09-22T12:36:02.139Z"
    },
    {
      "questionId": 22,
      "updatedAt": "2017-09-22T12:36:06.128Z"
    },
    {
      "questionId": 37,
      "updatedAt": "2017-09-25T10:54:56.570Z"
    },
    {
      "questionId": 38,
      "updatedAt": "2017-09-25T10:54:58.493Z"
    },
    {
      "questionId": 24,
      "updatedAt": "2017-09-25T13:32:55.687Z"
    },
    {
      "questionId": 39,
      "updatedAt": "2017-09-25T14:09:28.693Z"
    },
    {
      "questionId": 40,
      "updatedAt": "2017-09-25T14:09:29.674Z"
    },
    {
      "questionId": 41,
      "updatedAt": "2017-09-25T14:09:30.527Z"
    },
    {
      "questionId": 44,
      "updatedAt": "2017-09-29T08:32:07.403Z"
    }
  ]
}
```

This endpoint current gets the ID's and last updated timestamps for all user answers.

### HTTP Request

`GET https://api.getvista.co/v1/sync`

## Sync to server

```javascript
import Api from 'api'

const params = {
  update: [
    // a array of answer objects to update on the server
  ],
  get: [
    // an array of question ID's to retrieve answers for
  ],
  delete: [
    // an array of question ID's to delete answers for
  ],
  add: [
    // a array of answer objects to create on the server
  ]
}

Api.post(`/sync`, params).then(response => {
  const { data } = response
}).catch((error) => {
  Api.handleError(error)
})
```

> The request should look like:

```json
{
  "update": [
    {
      "questionId": 23,
      "values": "Online!",
      "note": null
    }
  ],
  "get": [
    34,
    26,
    36
  ],
  "delete": [
    24
  ],
  "add": [
    {
      "questionId": 24,
      "values": "Less than $1000"
    }
  ]
}
```

> The response will return the answer objects for the question ID's in the `get` param:

```json
[
  {
    "id": 15,
    "questionId": 34,
    "values": "No",
    "note": null,
    "synced": true
  },
  {
    "id": 16,
    "questionId": 26,
    "values": "Yes",
    "note": null,
    "synced": true
  },
  {
    "id": 18,
    "questionId": 36,
    "values": "First floor",
    "note": null,
    "synced": true
  }
]
```

This endpoint allows retrieving, updating, creating and deleting answers from the server in one request. The ID's inside the `get` parameter will be returned in the response.

### HTTP Request

`POST https://api.getvista.co/v1/sync`
