Feature: homework 

Background: define url
    * url apiUrl
    * def timeValidator = read ('classpath:helpers/timeValidator.js')


Scenario: favorite articles
    Given path 'articles'
    Given params {limit: 10 , offset: 0}
    When method Get 
    Then status 200
    * def slugId = response.articles[0].slug
    * def favorites = response.articles[0].favoritesCount
    * print slugId
    * print favorites

    Given path 'articles',slugId,'favorite'
    When method Post
    And request {}
    Then status 200

    And match response == 
    """
                {
        "article":{
            "title":"#string",
            "slug":"#string",
            "body":"#string",
            "createdAt":"#? timeValidator(_)",
            "updatedAt":"#? timeValidator(_)",
            "tagList":"#array",
            "description":"#string",
            "author":{
                "username":"#string",
                "bio":"##string",
                "image":"##string",
                "following":"#boolean"
            },
            "favorited":"#boolean",
            "favoritesCount":"#number"
        }
        }

    """
        #And match response.article.favoritesCount == 1

    Given path 'articles'
    Given params {favorited: karatetester1196, limit: 10, offset:0}
    When method Get
    Then status 200
    And match each response.articles ==
    """
        {
            "title":"#string",
            "slug":"#string",
            "body":"#string",
            "createdAt":"#? timeValidator(_)",
            "updatedAt":"#? timeValidator(_)",
            "tagList":"#array",
            "description":"#string",
            "author":{
               "username":"#string",
               "bio":"##string",
               "image":"#string",
               "following":"#boolean"
            },
            "favorited":"#boolean",
            "favoritesCount":"#number"
         }
    """
    And match response.articles[*].slug contains slugId