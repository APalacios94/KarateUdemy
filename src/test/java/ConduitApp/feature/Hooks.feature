
Feature: Hooks

Background: Hooks

   # * def result = call read('classpath:helpers/Dummy.feature')
    #* def username = result.username

    #after hooks

    #* configure afterScenario = function(){ karate.call('classpath:helpers/Dummy.feature') }
    * configure afterScenario = 
    """
        function(){
            karate.log("After feature text")
        }
    """


Scenario: First scenario
    * print "this is first scenario"
    #* print username


Scenario: second scenario
    * print "this is the second scenario"
    #* print username
