# Questions

## Get all questions

```javascript
import Api from 'api'

Api.get(`/questions`).then(response => {
  const { data: questions } = response
}).catch((error) => {
  Api.handleError(error)
})
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": 25,
    "title": "Do you want acess to cooking facilities?",
    "categoryId": 4212,
    "kind": "option",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 30,
        "title": "Yes",
        "description": null,
        "photo": null
      },
      {
        "id": 31,
        "title": "No",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 26,
    "title": "Do you want access to wifi inside your room?",
    "categoryId": 4212,
    "kind": "option",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 32,
        "title": "Yes",
        "description": null,
        "photo": null
      },
      {
        "id": 33,
        "title": "No",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 27,
    "title": "Where do your prefer your room to be near?",
    "categoryId": 4212,
    "kind": "option",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 34,
        "title": "Reception area",
        "description": null,
        "photo": null
      },
      {
        "id": 35,
        "title": "Dining area",
        "description": null,
        "photo": null
      },
      {
        "id": 36,
        "title": "Entertainment area",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 29,
    "title": "What room do you prefer?",
    "categoryId": 4212,
    "kind": "option",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 40,
        "title": "Balcony room",
        "description": null,
        "photo": null
      },
      {
        "id": 41,
        "title": "Suite",
        "description": null,
        "photo": null
      },
      {
        "id": 42,
        "title": "Simple room",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 30,
    "title": "Do you prefer room with windows?",
    "categoryId": 4212,
    "kind": "option",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 43,
        "title": "No windows",
        "description": null,
        "photo": null
      },
      {
        "id": 44,
        "title": "Small windows",
        "description": null,
        "photo": null
      },
      {
        "id": 45,
        "title": "Big windows",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 32,
    "title": "Do you want to dine in at the hotel restaurant or elsewhere?",
    "categoryId": 4212,
    "kind": "option",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 48,
        "title": "Hotel restaurant",
        "description": null,
        "photo": null
      },
      {
        "id": 49,
        "title": "Elsewhere",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 33,
    "title": "Do you want access to laundry facility or would you rather just pay for it to get done?",
    "categoryId": 4212,
    "kind": "option",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 50,
        "title": "Yes",
        "description": null,
        "photo": null
      },
      {
        "id": 51,
        "title": "No",
        "description": null,
        "photo": null
      },
      {
        "id": 52,
        "title": "Pay for it",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 34,
    "title": "Are you willing to pay extra for parking?",
    "categoryId": 4213,
    "kind": "option",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 53,
        "title": "Yes",
        "description": null,
        "photo": null
      },
      {
        "id": 54,
        "title": "No",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 35,
    "title": "Do you prefer valet parking or would you rather park yourself?",
    "categoryId": 4213,
    "kind": "option",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 55,
        "title": "Valet",
        "description": null,
        "photo": null
      },
      {
        "id": 56,
        "title": "Self park",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 36,
    "title": "What floor do you want your room on?",
    "categoryId": 4215,
    "kind": "option",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 57,
        "title": "Ground floor",
        "description": null,
        "photo": null
      },
      {
        "id": 58,
        "title": "First floor",
        "description": null,
        "photo": null
      },
      {
        "id": 59,
        "title": "Second floor",
        "description": null,
        "photo": null
      },
      {
        "id": 60,
        "title": "Top floor",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 37,
    "title": "How would you rate your lifestyle?",
    "categoryId": 4224,
    "kind": "option",
    "lockingConditions": [],
    "intro": true,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 61,
        "title": "Spare no expense",
        "description": null,
        "photo": null
      },
      {
        "id": 62,
        "title": "Like the finer things in life",
        "description": null,
        "photo": null
      },
      {
        "id": 63,
        "title": "Spend money but only on special occasions",
        "description": null,
        "photo": null
      },
      {
        "id": 64,
        "title": "As economical as possible",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 23,
    "title": "What booking method do you prefer to use?",
    "categoryId": 4222,
    "kind": "option",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 21,
        "title": "Online",
        "description": null,
        "photo": null
      },
      {
        "id": 22,
        "title": "Via email",
        "description": null,
        "photo": null
      },
      {
        "id": 23,
        "title": "Via telephone",
        "description": null,
        "photo": null
      },
      {
        "id": 24,
        "title": "In person",
        "description": null,
        "photo": null
      },
      {
        "id": 25,
        "title": "Third party website",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 21,
    "title": "Who will accompany you on your visit to the hotel?",
    "categoryId": 4222,
    "kind": "unordered_list",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 10,
        "title": "No one",
        "description": null,
        "photo": null
      },
      {
        "id": 11,
        "title": "Partner",
        "description": null,
        "photo": null
      },
      {
        "id": 12,
        "title": "Family / relatives",
        "description": null,
        "photo": null
      },
      {
        "id": 13,
        "title": "Friends",
        "description": null,
        "photo": null
      },
      {
        "id": 14,
        "title": "Co-workers",
        "description": null,
        "photo": null
      },
      {
        "id": 15,
        "title": "Business partners",
        "description": null,
        "photo": null
      },
      {
        "id": 16,
        "title": "Other",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 19,
    "title": "What are your main reasons to visit a hotel?",
    "categoryId": 4222,
    "kind": "unordered_list",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 1,
        "title": "Rest and relaxation",
        "description": null,
        "photo": {
          "id": 4109,
          "largeUrl": "https://some.url/some-photo.jpg",
          "mediumUrl": "https://some.url/some-photo.jpg",
          "squareUrl": "https://some.url/some-photo.jpg",
          "thumbUrl": "https://some.url/some-photo.jpg"
        }
      },
      {
        "id": 2,
        "title": "Visiting friends and family",
        "description": null,
        "photo": null
      },
      {
        "id": 3,
        "title": "Business reasons",
        "description": null,
        "photo": null
      },
      {
        "id": 4,
        "title": "Attending a conference, congress, seminar etc",
        "description": null,
        "photo": null
      },
      {
        "id": 5,
        "title": "Health",
        "description": null,
        "photo": null
      },
      {
        "id": 6,
        "title": "Sports and recreation",
        "description": null,
        "photo": null
      },
      {
        "id": 7,
        "title": "Other",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 22,
    "title": "How often do you stay at hotels?",
    "categoryId": 4222,
    "kind": "option",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 17,
        "title": "Every few years",
        "description": null,
        "photo": null
      },
      {
        "id": 18,
        "title": "Once a year",
        "description": null,
        "photo": null
      },
      {
        "id": 19,
        "title": "Several times (3-5) a year",
        "description": null,
        "photo": null
      },
      {
        "id": 20,
        "title": "More than 5 times a year",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 20,
    "title": "Will your trip to the hotel be organized through a travel agency or another organizer?",
    "categoryId": 4222,
    "kind": "option",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 8,
        "title": "Yes",
        "description": null,
        "photo": null
      },
      {
        "id": 9,
        "title": "No",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 38,
    "title": "How many times a year do you travel for leisure?",
    "categoryId": 4224,
    "kind": "option",
    "lockingConditions": [],
    "intro": true,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 65,
        "title": "1-2",
        "description": null,
        "photo": null
      },
      {
        "id": 66,
        "title": "3-5",
        "description": null,
        "photo": null
      },
      {
        "id": 67,
        "title": "As much as possible",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 39,
    "title": "How many times a year do you travel for business?",
    "categoryId": 4224,
    "kind": "option",
    "lockingConditions": [],
    "intro": true,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 68,
        "title": "1-2",
        "description": null,
        "photo": null
      },
      {
        "id": 69,
        "title": "3-5",
        "description": null,
        "photo": null
      },
      {
        "id": 70,
        "title": "5-10",
        "description": null,
        "photo": null
      },
      {
        "id": 71,
        "title": "Once per month",
        "description": null,
        "photo": null
      },
      {
        "id": 72,
        "title": "Too much than I'd care to admit",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 41,
    "title": "Do you have a pallet for good wine?",
    "categoryId": 4224,
    "kind": "option",
    "lockingConditions": [],
    "intro": true,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 75,
        "title": "Yes",
        "description": null,
        "photo": null
      },
      {
        "id": 76,
        "title": "No",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 42,
    "title": "How often do you eat out per month?",
    "categoryId": 4224,
    "kind": "number",
    "lockingConditions": [],
    "intro": true,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 84,
        "title": "0",
        "description": null,
        "photo": null
      },
      {
        "id": 85,
        "title": "30",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 43,
    "title": "What are you allergic to, if anything? ",
    "categoryId": 4224,
    "kind": "text",
    "lockingConditions": [],
    "intro": true,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": []
  },
  {
    "id": 44,
    "title": "Testing number range",
    "categoryId": 4215,
    "kind": "number_range",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 77,
        "title": "0",
        "description": null,
        "photo": null
      },
      {
        "id": 78,
        "title": "20",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 45,
    "title": "Ordered list test",
    "categoryId": 4222,
    "kind": "ordered_list",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 79,
        "title": "One",
        "description": null,
        "photo": null
      },
      {
        "id": 80,
        "title": "Two",
        "description": null,
        "photo": null
      },
      {
        "id": 81,
        "title": "Three",
        "description": null,
        "photo": null
      },
      {
        "id": 82,
        "title": "Four",
        "description": null,
        "photo": null
      },
      {
        "id": 83,
        "title": "Five",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 46,
    "title": "Number test",
    "categoryId": 4215,
    "kind": "number",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 86,
        "title": "12",
        "description": null,
        "photo": null
      },
      {
        "id": 87,
        "title": "24",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 47,
    "title": "Time test",
    "categoryId": 4215,
    "kind": "time",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": null,
    "photo": null,
    "answers": [
      {
        "id": 88,
        "title": "0",
        "description": null,
        "photo": null
      },
      {
        "id": 89,
        "title": "24",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 24,
    "title": "How much do you plan to spend during your visit at the hotel on restaurants/cafes?",
    "categoryId": 4214,
    "kind": "option",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": "Tell us more about how you want to spend",
    "photo": null,
    "answers": [
      {
        "id": 26,
        "title": "Less than $1000",
        "description": null,
        "photo": null
      },
      {
        "id": 27,
        "title": "$1000-5000",
        "description": null,
        "photo": null
      },
      {
        "id": 28,
        "title": "$5000-10000",
        "description": null,
        "photo": null
      },
      {
        "id": 29,
        "title": "Above $10000",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 31,
    "title": "Do you prefer breakfast in bed?",
    "categoryId": 4212,
    "kind": "boolean",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": "",
    "photo": null,
    "answers": [
      {
        "id": 46,
        "title": "Yes",
        "description": null,
        "photo": null
      },
      {
        "id": 47,
        "title": "No",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 28,
    "title": "Do you want a connecting door suite?",
    "categoryId": 4212,
    "kind": "boolean",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": "",
    "photo": null,
    "answers": [
      {
        "id": 37,
        "title": "Yes",
        "description": null,
        "photo": null
      },
      {
        "id": 38,
        "title": "No",
        "description": null,
        "photo": null
      },
      {
        "id": 39,
        "title": "Don't know",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 40,
    "title": "Would you consider yourself a 'foodie'? ",
    "categoryId": 4224,
    "kind": "boolean",
    "lockingConditions": [],
    "intro": true,
    "allowsNote": true,
    "noteTitle": "",
    "photo": null,
    "answers": [
      {
        "id": 73,
        "title": "Yes",
        "description": null,
        "photo": null
      },
      {
        "id": 74,
        "title": "No",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 48,
    "title": "Temperature test",
    "categoryId": 4215,
    "kind": "temperature",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": "",
    "photo": null,
    "answers": [
      {
        "id": 90,
        "title": "12",
        "description": null,
        "photo": null
      },
      {
        "id": 91,
        "title": "24",
        "description": null,
        "photo": null
      }
    ]
  },
  {
    "id": 49,
    "title": "Temperature range test",
    "categoryId": 4215,
    "kind": "temperature_range",
    "lockingConditions": [],
    "intro": false,
    "allowsNote": true,
    "noteTitle": "",
    "photo": null,
    "answers": [
      {
        "id": 92,
        "title": "0",
        "description": null,
        "photo": null
      },
      {
        "id": 93,
        "title": "30",
        "description": null,
        "photo": null
      }
    ]
  }
]
```

This endpoint gets all questions.

### HTTP Request

`GET https://api.getvista.co/v1/questions`
