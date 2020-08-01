Feature: Basic Feature

Scenario: Basic Scenario
	Given there is something

	When I do something

	Then something should happen

@ignore
Scenario Outline: A scenario which is actually several examples
	When adding '<arg1>' and '<arg2>'

	Then the result should be '<result>'

	Examples:
		| arg1 | arg2 | result |
		| 1    |1     | 2      |
		| 10   |20    | 30     |
		| 42   |17    | 59     |

