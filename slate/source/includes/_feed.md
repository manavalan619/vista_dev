# Feed

## Get feed

> To get feed elements, use this code in the app:

```javascript
import Api from 'api'

Api.get('/feed').then(response => {
  const { data: { articles, interactions } } = response
})
```

> The above command returns JSON structured like this:

```json
{
  "articles": [
    {
      "id": 1,
      "title": "In et et rerum.",
      "content": "\u003cdiv\u003eAenean lacinia bibendum nulla sed consectetur. Nulla vitae elit libero, a pharetra augue. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis in, egestas eget quam.\u003cbr\u003e\u003cbr\u003eFusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Aenean lacinia bibendum nulla sed consectetur. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Maecenas faucibus mollis interdum. Aenean lacinia bibendum nulla sed consectetur.\u003cbr\u003e\u003cbr\u003eAenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Nullam quis risus eget urna mollis ornare vel eu leo.\u003c/div\u003e",
      "publishedAt": "2017-10-27T10:20:00.000Z",
      "type": "article",
      "headerImage": {
        "id": 4127,
        "largeUrl": "https://some.url/some-photo.jpg",
        "mediumUrl": "https://some.url/some-photo.jpg",
        "squareUrl": "https://some.url/some-photo.jpg",
        "thumbUrl": "https://some.url/some-photo.jpg"
      }
    },
    {
      "id": 3,
      "title": "Reprehenderit quae rerum voluptatibus consequatur molestiae.",
      "content": "Ut natus alias sit quas a. Nulla pariatur voluptatem esse labore explicabo ut soluta. Quaerat corrupti consequatur asperiores quam veniam animi reprehenderit. Neque et excepturi non consequatur iure dolore.",
      "publishedAt": "2017-10-25T14:44:11.965Z",
      "type": "article",
      "headerImage": {
        "id": 4128,
        "largeUrl": "https://some.url/some-photo.jpg",
        "mediumUrl": "https://some.url/some-photo.jpg",
        "squareUrl": "https://some.url/some-photo.jpg",
        "thumbUrl": "https://some.url/some-photo.jpg"
      }
    },
    {
      "id": 2,
      "title": "Consequatur architecto est quos.",
      "content": "Quidem voluptates numquam. Eum dolor commodi ullam ducimus voluptatem. Sint cumque aut id ut quo. Error aut dolore ut non maxime. Tempora necessitatibus debitis alias omnis ad unde.",
      "publishedAt": "2017-10-25T14:44:01.694Z",
      "type": "article",
      "headerImage": null
    }
  ],
  "interactions": []
}
```

Returns a list of news articles and interactions. This endpoint is likely to change as more elements from the feed are added.

### HTTP Request

`GET https://api.getvista.co/v1/feed`
