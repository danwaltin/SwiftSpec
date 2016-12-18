Feature: Scenarios with ignore tag are not executed

@ignore
Scenario: This scenario would fail if executed
	When executing a step that fails

Scenario: This scenario will succeed when executed
	When executing a step that succeedes

