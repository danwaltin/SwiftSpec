//
//  StepParameterBindings.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-08-01.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import SwiftSpec
import XCTest

class StepParameterBindings : Bindings {
	override func defineBindings() {
		addBinding(stepText: "the following accounts") {
			self.accounts = self.tableToAccounts($0.table!)
		}
		
		addBinding(stepText: "the balance of account '(.*)' is changed to (.*)") {
			let account = $0.matchedParameters[0]
			let newBalance = Int($0.matchedParameters[1])!
			self.setBalance(ofAccount: account, to: newBalance)
		}

		addBinding(stepText: "should accounts as follows exist") {
			let expected = self.tableToAccounts($0.table!)
			
			let actual = self.accounts
			
			XCTAssertEqual(actual, expected)
		}
	}
	
	private func setBalance(ofAccount name: String, to balance: Int) {
		let current = self.accounts
		
		var newList = [Account]()
		for account in current {
			var copy = account
			if copy.name == name {
				copy.balance = balance
			}
			newList.append(copy)
		}
		self.accounts = newList
		
	}
	
	private var accounts: [Account] {
		get {
			let accounts: [Account] = ScenarioContext.current.get("accounts")
			return accounts
		}
		set(newValue) {
			ScenarioContext.current["accounts"] = newValue
		}
	}
	
	private func tableToAccounts(_ table: Table) -> [Account] {
		return table.rows.map {row in rowToAccount(row)}
	}
	
	private func rowToAccount(_ row: TableRow) -> Account {
		var a = Account()
		a.name = row["Name"]
		a.balance = Int(row["Balance"])!
		
		return a
	}
}

struct Account : Equatable {
	var name = ""
	var balance = 0
}

func ==(lhs: Account, rhs: Account) -> Bool {
	return lhs.name == rhs.name && lhs.balance == rhs.balance
}
