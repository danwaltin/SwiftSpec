Feature: steps parameters are passed to the binding methods

Scenario: Table parameters
	Given the following accounts
		| Name      | Balance |
		| Coffee    | 1111    |
		| Computers | 2222    |

	When the balance of account 'Computers' is changed to 3333

	Then should accounts as follows exist
		| Name      | Balance |
		| Coffee    | 1111    |
		| Computers | 3333    |
