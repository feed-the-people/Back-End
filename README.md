# Feed the People API


## Summary
  - [Endpoint](#endpoint)
  - [API calls](#api-calls)
    - [Users](#users)
      - [getUser](#getuser)
    - [Recipes](#recipes)
    - [Ingredients](#ingredients)
    
    
## Endpoint

API URL COMING SOON

## API Calls
### Users
#### getUser
Retreive a single user and all relevant information related to that user based on queried fields. Additional fields such as receipes for specific user is also available but not shown in example.
   
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

* Note: when calling recipies as a field for user, you must also query a field for recipe. See recipes for all queryble fields.

    
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
 ```json
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
  ### Recipes
  ### Ingredients
