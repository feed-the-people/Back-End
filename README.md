# Feed the People API


## Summary
  - [Endpoint](#endpoint)
  - [API calls](#api-calls)
    - [Users](#users)
      - [getUser](#getuser)
      - [userSignIn](#usersignin)
    - [Recipes](#recipes)
    - [Ingredients](#ingredients)
    
    
## Endpoint

```POST https://feed-the-people-api.herokuapp.com/graphql```

## API Calls
### Users
#### getUser
Retreive a single user and all relevant information related to that user based on queried fields.

Arguments:
- id - integer of user's id #

Fields:
- id
- username
- email
- firstName
- lastName
- street
- city
- state
- zip
- createdAt
- updatedAt
- recipes* - displays only recipes created by the user

** Note: when calling recipies as a field for user, you must also query a field for recipe. See recipes for all queryble fields.

    
Example request:
```graphql
query {
  getUser(id: 2) {
    username
    email
    recipes {
      title
      avg_rating
    }
}
 ```
 
 Example response:
 ```yaml
 {
  "data": {
    "getUser": {
      "username": "Buffy",
      "email": "vampire_slayer@aol.com",
      "recipes": [
        {
          "title": "Tiramisù",
          "avgRating": null
        },
        {
          "title": "Barbecue Ribs",
          "avgRating": 3.5
        },
        {
          "title": "Meatballs with Sauce",
          "avgRating": 4.9
        },
        {
          "title": "Chicken Fajitas",
          "avgRating": null
        }
      ]
    }
  }
}
 ```
 
 #### userSignIn
 
Authenticate the user whom already has an account. Returns user object with all user related data based on queryable fields.

Arguments:
- username - string
- password - string

Fields:
- token*
- user
  - id
  - username
  - email
  - firstName
  - lastName
  - street
  - city
  - state
  - zip
  - createdAt
  - updatedAt
  - recipes - displays only recipes created by the user

** Note: Token may be needed for further authentication and highly recommend to query and store during user session

    
Example request:
```graphql
mutation {
	userSignIn(input: { credentials: { username: "Triplicate Thirteen" password: "1234" }}) {
    token
    user {
      id
      image
      username
      email
    }
  }
}
 ```
 
 Example response:
 ```yaml
{
  "data": {
    "userSignIn": {
      "token": "dh9dmyyHYjQ0vLZbIjxredLARA==--CrBOAsYNwVV8n0xa--4vio0pppt+curOPLIXaZaA==",
      "user": {
        "id": "1",
        "image": "https://robohash.org/my-own-slug.png?size=50x50&set=set1",
        "username": "Triplicate Thirteen",
        "email": "131313@aol.com"
      }
    }
  }
}
 ```
  ### Recipes
  ### Ingredients
