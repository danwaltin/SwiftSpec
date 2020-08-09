Feature: Scenario Outline
	A scenario outline is a scenario
	which is actually several examples
	
Scenario Outline: The sum of two numbers
	The steps are parameterized
	
	When adding '<arg1>' and '<arg2>'

	Then the result should be '<result>'

	Examples:
		| arg1 | arg2 | result |
		| 1    |1     | 2      |
		| 10   |20    | 30     |
		| 42   |17    | 59     |

Scenario Outline: Math using reverse polish notation
	The examples can be grouped and named
	
	Given that operand '<operand1>' has been entered
	And that operand '<operand2>' has been entered
	
	When entering operator '<operator>'
	
	Then the result should be '<result>'
	
	Examples: Addition
		| operand1 | operand2 | operator | result |
		| 1        | 1        | add      | 2      |
		| 10       | 20       | add      | 30     |

	Examples: Subtraction
		| operand1 | operand2 | operator | result |
		| 1        | 1        | subtract | 0      |
		| 10       | 20       | subtract | -10    |

Scenario Outline: Adding a number to itself
	The same parameter can occur in several places

	When adding '<arg>' and '<arg>'

	Then the result should be '<result>'

	Examples:
		| arg | result |
		| 1   | 2      |
		| 42  | 84     |

