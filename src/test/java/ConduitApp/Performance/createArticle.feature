Feature: Tests for the home page

Background: define URL

    Given url apiUrl
    * def articleRequestBody = read ('classpath:ConduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
    * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().d  ffescription
    * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body
    
Scenario: Create and delete article 
    Given path 'articles'
    And request articleRequestBody
    When method Post
    Then status 200
    * def articleId = response.article.slug

    Given path 'articles',articleId
    When method Delete
    Then status 200