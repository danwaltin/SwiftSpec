Feature: in every scenario a new scenario context is available

Scenario: Data added to the scenario context is available in subsequent steps
	Given that the value 'foo' is added to the current scenario context using the key 'bar'

	Then the current scenario context returns the value 'foo' for the key 'bar'

Scenario: The scenario context is cleared for each scenario
	Given a new scenario

	Then the current scenario context returns nil for the key 'bar'
