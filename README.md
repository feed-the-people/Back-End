# Feed the People API
![Travis-ci](https://travis-ci.com/feed-the-people/Back-End.svg?branch=main)

## Summary
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
    - [Testing](#testing)
  - [Endpoint](#endpoint)
  - [API calls](#api-calls)
    - [Users](#users)
      - [registerUser](#registeruser)
      - [getUser](#getuser)
      - [userSignIn](#usersignin)
      - [updateUser](#updateuser)
    - [Recipes](#recipes)
      - [createRecipe](#createrecipe)
      - [getNpo](#getnpo)
      - [recipeById](#recipebyid)
      - [allRecipes](#allrecipes)
      - [updateRating](#updaterating)
    - [Ingredients](#ingredients)
      - [createIngredient](#createingredient)
      - [updateIngredient](#updateingredient)
    - [UserRecipes](#userrecipes)
      - [createUserRecipe](#createuserrecipe)

## Prerequisites
  - Rails 6.0.3.4
  - Ruby 2.5.3
  
## Setup
  - Run `bundle install`
  - Run `rails db:create`
  - Run `rails db:migrate`
  - Run `rails db:seed`
  
  ### Testing
    - `bundle exec rspec`
    - All tests should be passing

## Endpoint

```POST https://feed-the-people-api.herokuapp.com/graphql```

## API Calls
### Users

  #### registerUser
  Register a new user by entering ID information.

  Arguments:
  - id
  - username
  - firstName
  - lastName
  - email
  - state
  - city
  - street
  - zip
  - image

  Fields
  - id
  - username
  - firstName
  - lastName
  - email
  - state
  - city
  - street
  - zip
  - image
  - createdAt
  - updatedAt

  Example request:
  ```graphql
  mutation {
              registerUser( input: {
                image: "www.image.com",
                firstName: "Test",
                lastName: "User",
                email: "test@email.com",
                state: "CO",
                city: "Denver",
                street: "1234 Road Street",
                zip: "1234",
                authProvider: {
                  credentials: {
                    username: "AnothaOne",
                    password: "[omitted]"
                  }
                }
              }
            )
            { user {
                id
                username
                firstName
                lastName
                email
                state
                city
                street
                zip
                image
                }
              }
            }
```

Example response:
```yaml
{
  "data": {
    "registerUser": {
      "user": {
        "id":"164",
        "username":"AnothaOne",
        "firstName":"Test",
        "lastName":"User",
        "email":"test@email.com",
        "state":"CO",
        "city":"Denver",
        "street":"1234 Road Street",
        "zip":"12345",
        "image":"www.image.com"
              }
            }
          }
}
```

  #### getUser
  Retrieve a single user and all relevant information related to that user based on queried fields.

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
  - userRecipes - displays a join table for a user's purchased recipes

  ** Note: when calling recipies as a field for user, you must also query a field for recipe. See recipes for all queryble fields.


  Example request:
  ```graphql
  query {
    getUser(id: 2) {
      username
      email
      recipes {
        title
        avgRating
      }
      userRecipes {
        amountDonated
        recipes {
          title
          avgRating
        }
      }
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


#### updateUser
Change user profile information.

Arguments:
  - image
  - username
  - firstName
  - lastName
  - email
  - street
  - city
  - state
  - zip

Fields
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

Example request:
```graphql
mutation {
  updateUser(input: {
    params: {
      id: 198,
      image: "https://robohash.org/new-slug-edit-update.png?size=50x50&set=set1",
      username: "food_love123",
      firstName: "Chef",
      lastName: "Ratatouille",
      email: "bonappetit@email.com",
      street: "234 Paris Ave",
      city: "New York",
      state: "NY",
      zip: "10025"
            }
          })
    {
      user {
        id
        image
        username
        firstName
        lastName
        email
        street
        city
        state
        zip
      }
    }
}
```
Example response:
```yaml
{
  "data": {
    "updateUser": {
      "user": {
        "id":"198",
       "image":"https://robohash.org/new-slug-edit-update.png?size=50x50&set=set1",
       "username":"food_love123",
       "firstName":"Chef",
       "lastName":"Ratatouille",
       "email":"bonappetit@email.com",
       "street":"234 Paris Ave",
       "city":"New York",
       "state":"NY",
       "zip":"10025"
      }
    }
  }
}
```


### Recipes
#### createRecipe
Creates and returns a single recipe object.

Arguments:
- userId - integer of user's id #
- title - string
- image - string
- description - string
- instructions - string
- charityId - string
- charityName - string
- ingredients - array of objects/hashs (see example below)
  - name - string
  - amount - string
- image - string (optional - not displayed in example)

Fields:
- recipe
  - id
  - image
  - title
  - description
  - instructions
  - charityId
  - charityName
  - avgRating
  - userId
  - createdAt
  - updatedAt
  - ingredients
    - name
    - amount

Example request:
```graphql
mutation {
  createRecipe(input: {params: {
       userId: 1,
       title: "Chicken Parmesan",
       image: "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2019/7/11/0/FNK_the-best-chicken-parmesan_H_s4x3.jpg.rend.hgtvcom.826.620.suffix/1562853897238.jpeg",
       description: "A classic favorite!",
       instructions: "1. chicken 2.???? 3. profit",
       charityId: "533423",
       charityName: "Cookies for Kevin Fund",
       ingredients: [{name: "Chicken", amount: "2 lbs"}, {name: "Parmesan", amount: "5 gallons"}]}}) {
    recipe {
      id
      title
      description
      instructions
      ingredients {
        name
        amount
      }
    }
  }
}
```

Example response:
```yaml
{
  "data": {
    "createRecipe": {
      "recipe": {
        "id": "5",
        "title": "Chicken Parmesan",
        "image": "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2019/7/11/0/FNK_the-best-chicken-parmesan_H_s4x3.jpg.rend.hgtvcom.826.620.suffix/1562853897238.jpeg",
        "description": "A classic favorite!",
        "instructions": "1. chicken 2.???? 3. profit",
        "ingredients": [
          {
            "name": "Chicken",
            "amount": "2 lbs"
          },
          {
            "name": "Parmesan",
            "amount": "5 gallons"
          }
        ]
      }
    }
  }
}
```

#### getNpo
Retrieve a Non-Profit Organization from the ProPublica API, based on User chosen search terms, to be appended to a recipe being created.

  Arguments:
  - searchTerm - chosen by user to find related NPO

  Fields:
  - ein
  - name
  - city
  - state

  Example request:
```graphql
    query {
      getNpo( searchTerm: "Food Bank of the Rockies") {
          ein
          name
          city
          state
                                                      }
          }
```

Example response:
```yaml
{
  "data": {
    "getNpo": {
      [
        {"ein":"840772672", "name":"FOOD BANK OF THE ROCKIES", "city":"DENVER", "state":"CO"},
      {"ein":"453855680", "name":"WYOMING FOOD BANK OF THE ROCKIES", "city":"EVANSVILLE", "state":"WY"},
      {"ein":"260211983", "name":"FOOD BANK OF THE ROCKIES ENDOWMENTFUND", "city":"DENVER", "state":"CO"}
      ]
              }
          }
}  
```

#### recipeById
Return a specific recipe by it's assigned ID

Arguments:
- id

Fields:
- id
- title
- description
- instructions
- image
- userId
- avgRating
- charityId
- charityName
- updatedAt
- createdAt
- ingredients
  - name
  - amount

Example request:
```graphql
query {
          recipeById(id: 299) {
            id
            title
            description
            instructions
            image
            userId
            avgRating
            charityId
            charityName
            updatedAt
            createdAt
            ingredients {
              name
              amount
            }
          }
        }
```

Example response:
```yaml
{
  "data": {
    "recipeById": {
      "id":"299",
      "title":"Chicken Fajitas",
      "description": "Thick slices of French toast bread, brown sugar, half-and-half and vanilla, topped with powdered sugar. With two eggs served any style, and your choice of smoked bacon or smoked ham.",
      "instructions": "Eaque libero voluptas. Reiciendis aliquid et. Ea dolores esse. Eaque blanditiis voluptatem. Illo aliquid enim.",
      "image":"https://loremflickr.com/50/60/food",
      "userId":"289",
      "avgRating":nil,
      "charityId":"1",
      "charityName":"Pollich Group Group",
      "updatedAt":"2021-01-09T22:54:26Z",
      "createdAt":"2021-01-09T22:54:26Z",
      "ingredients": [
        {"name":"Currants", "amount":"1 tablespoon"},
        {"name":"Black Eyed Beans", "amount":"2 tablespoon"},
        {"name":"Asafoetida", "amount":"1/4 gallon"}
      ]
    }
  }
}
```

#### allRecipes
Return all available recipes (used in user feed, sorted by descending createdAt)

Fields:
  - id
  - title
  - description
  - instructions
  - image
  - avgRating
  - userId
  - charityId
  - createdAt
  - updatedAt

Example request:
```graphql
    query {
      allRecipes {
        id
        title
        description
        instructions
        image
        avgRating
        userId
        charityId
        createdAt
        updatedAt
          }
        }
```

Example response:
```yaml
{
  "data": {
    "allRecipes": [
      {
        "id":"338",
        "title":"Kebab",
        "description":"Fresh Norwegian salmon, lightly brushed with our herbed Dijon mustard sauce, with choice of two sides.",
        "instructions":"Corrupti et beatae. Nihil nulla officiis. Voluptatem sunt voluptates. Et voluptatibus non.",
        "image":"https://loremflickr.com/50/60/food",
        "avgRating":nil,
        "userId":"329",
        "charityId":"1",
        "createdAt":"2021-01-09T23:06:40Z",
        "updatedAt":"2021-01-09T23:06:40Z"},
      {
        "id":"337",
          "title":"Souvlaki",
          "description":
          "Granny Smith apples mixed with brown sugar and butter filling, in a flaky all-butter crust, with ice cream.",
          "instructions":"Iusto consectetur fuga. Dolores aut eaque. Aut et ullam.",
          "image":"https://loremflickr.com/50/60/food",
          "avgRating":nil,
          "userId":"328",
          "charityId":"1",
          "createdAt":"2021-01-09T23:06:40Z",
          "updatedAt":"2021-01-09T23:06:40Z"
        }
    ]
  }
}
```

#### updateRating
Allows a User to add a rating to a purchased recipe.

Arguments:
- id
- recipeRating

Fields:
- id
- recipeRating

Example request:
```graphql
    mutation {
          updateRating(input: { params: { id: 9, recipeRating: 3 } }) {
            userRecipe {
              id
              recipeRating
            }
          }
        }
```

Example response:
```yaml
{
  "data": {
    "updateRating": {
      "userRecipe": {
        "id":"75",
        "recipeRating":3
      }
    }
  }
}
```

### Ingredients

  #### createIngredient
  Add specific ingredient to already created recipe.

  Arguments:
  - recipeId
  - name
  - amount

  Fields:
  - name
  - amount

  Example request:
  ```graphql
      mutation {
                createIngredient( input: { params: {
                  recipeId: 9
                  name: "Oats"
                  amount: "1 tsp"
                  }})
                  {
                  ingredient {
                      name
                      amount
                    }
                  }
                }
  ```

  Example response:
  ```yaml
  {
    "data": {
      "createIngredient": {
        "ingredient": {
          "name":"Oats",
          "amount":"1 tsp"
        }
      }
    }
  }
  ```

#### updateIngredient
Allows a User to change specifics of an already created ingredient.

Arguments:
- id
- name
- amount

Fields:
- name
- amount

Example request:
```graphql
    mutation {
            updateIngredient( input: { params: {
              id: #{@ingredient.id.to_s}
              name: "changed ingredient"
              amount: "100 Cups" }})
              {
              ingredient {
                id
                name
                amount
              }
            }
          }
```

Example response:
```yaml
{
  "data": {
    "updateIngredient": {
      "ingredient": {
        "id":"121",
        "name":"changed ingredient",
        "amount":"100 Cups"
      }
    }
  }
}
```

### UserRecipes
Joins table to allow for users to see their own and other User's recipes.
#### createUserRecipe
Creates join between a user and a recipe.

Arguments:
- recipeId
- userId
- amountDonated

Fields:
- id
- userId
- recipeId
- amountDonated
- recipeRating
- createdAt
- updatedAt

Example request:
```graphql
    mutation {
                createUserRecipe(input: { params: {
                  recipeId: #{recipeId}
                  userId: #{userId}
                  amountDonated: "#{amountDonated}"
                }}) {
                  userRecipe {
                    id
                    userId
                    recipeId
                    amountDonated
                    recipeRating
                    createdAt
                    updatedAt
                  }
                }
              }
```

Example response:
```yaml
{
  "data": {
    "createUserRecipe": {
      "userRecipe": {
        "id":"93",
        "userId":"440",
        "recipeId":"438",
        "amountDonated":2.5,
        "recipeRating":nil,
        "createdAt":"2021-01-09T23:58:42Z",
        "updatedAt":"2021-01-09T23:58:42Z"
      }
    }
  }
}
```
