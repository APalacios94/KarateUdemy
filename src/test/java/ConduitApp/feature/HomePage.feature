
Feature: Test for the home page

    Background: Define Url 
        Given url apiUrl
        
        
    Scenario: Get all tags
        Given path 'tags'
        When method Get 
        Then status 200
        And match response.tags contains ['МІLF', 'Tееn']
        And match response.tags !contains 'truck'
        And match response.tags contains any ['МІLF', 'dog', 'cat']
        And match response.tags == '#array'
        And match each response.tags == '#string'

      
    Scenario: Get 10 articles From the page
        * def timeValidator = read ('classpath:helpers/timeValidator.js')
       
        Given path 'articles'
        Given params {limit: 10, offset: 0}
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response.articlesCount == 500
        And match response.articlesCount != 100
        And match response == {"articles": "#array", "articlesCount": 500}
        And match response.articles[0].createdAt contains "2021"
        And match response.articles[*].favoritesCount contains 0
        And match response.articles[*].author.bio contains null
        And match response..bio contains null
        And match each response..following == false
        And match each response..following == '#boolean'
        And match each response..favoritesCount == '#number'
        And match each response..bio == '##string'
        And match each response.articles == 
        """
            {
                "title": "#string",
                "slug": "#string",
                "body": "#string",
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "tagList": "#array",
                "description": "#string",
                "author": {
                    "username": "#string",
                    "bio": "##string",
                    "image": "#string",
                    "following": "#boolean"
                },
                "favorited": "#boolean",
                "favoritesCount": "#number"
            }
        """
    
    Scenario: Conditional logic
        Given path 'articles'
        Given params {limit: 10, offset: 0}
        When method Get
        Then status 200
        * def favoritesCount = response.articles[0].favoritesCount
        * def article = response.articles[0]

        #* if (favoritesCount == 0) karate.call('classpath:helpers/AddLikes.feature', article)
        *   def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature',article).likesCount : favoritesCount
       
        Given path 'articles'
        Given params {limit: 10, offset: 0}
        When method Get
        Then status 200
        And match response.articles[0].favoritesCount == result
        
        
    Scenario: Retry call
        * configure retry = { count: 10, interval: 5000}
        Given path 'articles'
        Given params {limit: 10, offset: 0}
        # es importante que coloque la condicion del retry antes del metodo Get o el que vaya a utilizar de no ser asi no funcionara
        And retry until response.articles[0].favoritesCount == 1
        When method Get
        Then status 200

        
    Scenario: Sleep call

        * def sleep = function(pause){ java.lang.Thread.sleep(pause) }
        Given path 'articles'
        Given params {limit: 10, offset: 0}
        When method Get
        * eval sleep(10000)
        Then status 200

        
    Scenario: Number to String 
        * def foo = 10
        * def json = {"bar": #(foo+'')}
        And match json == {"bar": "10"}l

        @debug
    Scenario: String to number 
        * def foo = '10'
        * def json = {"bar": #(foo*1)}
        * def json2 = {"bar": #(parseInt(foo))}l,,
        #* def json2 = {"bar": #(~~parseInt(foo))} de esta forma no lo transforma en un double es decir lo deja sin decimales
        And match json == {"bar": 10}
        And match json2 == {"bar": 10}