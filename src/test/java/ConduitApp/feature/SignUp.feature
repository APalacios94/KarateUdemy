
Feature: sign up new user

Background: Preconditions
    * url apiUrl
    * def timeValidator = read ('classpath:helpers/timeValidator.js')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    
    
Scenario: New user sign up
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUserName = dataGenerator.getrandomUserName()
    
    Given path 'users'
    And request
    """
            {
        "user": {
            "email": #(randomEmail),
            "password": "karatetester",
            "username": #(randomUserName)
        }
    }

    """
    When method Post 
    Then status 200
    And match response ==
    """
                {
            "user":  {
                "id": "#number",
                "email": #(randomEmail),
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "username": #(randomUserName),
                "bio": null,
                "image": null,
                "token": "#string"
            }
        }
    """

        
Scenario Outline: validate sign up error messages
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUserName = dataGenerator.getrandomUserName()
    
    Given path 'users'
    And request
    """
            {
        "user": {
            "email": "<email>",
            "password": "<password>",
            "username": "<username>"
        }
    }

    """
    When method Post    
    Then status 422
    And match response == <errorResponse>
  
    Examples:
    | email                | password     | username          | errorResponse                                      |
    | #(randomEmail)       | karatetester | karateUser123     | {"errors":{"username":["has already been taken"]}} |
    | KarateUser1@test.com | karatetester | #(randomUserName) | {"errors":{"email":["as already been taken"]}}     |

