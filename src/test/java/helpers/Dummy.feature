
Feature: Dummy

Scenario: Dummy
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def userName = dataGenerator.getrandomUserName()
    * print userName
    