@featureTag
Feature: Features and Scenarios can have associated tags

Scenario: A feature can have tags
	Then this feature has the tag 'featureTag'

@one
@two @three
Scenario: A scenario can have tags
	Then this scenario has the tags 'one', 'two' and 'three'

