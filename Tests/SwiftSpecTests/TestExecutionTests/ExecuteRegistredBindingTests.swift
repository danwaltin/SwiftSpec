//
//  ExecuteRegistredBindingTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-09.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import XCTest
@testable import SwiftSpec

class ExecuteRegistredBindingTests : XCTestCase {
	
	var mockBindingsRepository: MockBindingsRepository!
	var bindingsRegistry: BindingsRegistryImplementation!

	var stepNotFoundText: String = ""
	var moreThanOneStepFoundText: String = ""
	
	override func setUp() {
		mockBindingsRepository = MockBindingsRepository()
		bindingsRegistry = BindingsRegistryImplementation(bindingsRepository: mockBindingsRepository)
		
		stepNotFoundText = ""
		moreThanOneStepFoundText = ""
	}
	
	override func tearDown() {
		bindingsRegistry = nil
		mockBindingsRepository = nil
	}
	
	// MARK:
	// MARK: binding not found, or too many bindings found
	func test_zeroExistingBinding_shouldThrowStepBindingNotFound() {
		given_zeroStepBindings()
		
		when_executeStep(.Given, "any text")
		
		then_shouldThrowStepNotFoundError(forText: "any text")
	}

	func test_oneNonMatchingBinding_shouldThrowStepBindingNotFound() {
		given_stepBindings(
			nonMatching())
		
		when_executeStep(.Given, "non matchtext")
		
		then_shouldThrowStepNotFoundError(forText: "non matchtext")
	}

	func test_twoNonMatchingBindings_shouldThrowStepBindingNotFound() {
		given_stepBindings(
			nonMatching(),
			nonMatching())
		
		when_executeStep(.Given, "non matchtext")
		
		then_shouldThrowStepNotFoundError(forText: "non matchtext")
	}

	func test_twoMatchingBindings_shouldThrowMoreThanOnStepBindingFound() {
		given_stepBindings(
			matching(),
			matching())
		
		when_executeStep(.Given, "matchtext")
		
		then_shouldThrowStepNotFoundError(forText: "matchtext")
	}

	// MARK:
	// MARK: Found binding executed
	func test_oneMatchingBinding_stepBindingShouldBeExecuted() {
		
		let stepBinding = matching()

		given_stepBindings(
			stepBinding)

		when_executeStep(.Given, "text")
		
		XCTAssertTrue(stepBinding.hasBeenExecuted)
	}

	func test_twoBindings_secondMatching_secondBindingShouldBeExecutedButNotFirst() {
		
		let one = nonMatching()
		let two = matching()
		
		given_stepBindings(
			one,
			two)
		
		when_executeStep(.Given, "text")
		
		XCTAssertFalse(one.hasBeenExecuted)
		XCTAssertTrue(two.hasBeenExecuted)
	}

	// MARK:
	// MARK: Parameters sent to found binding
	func test_oneMatchingBinding_tableParameterIsSentToBinding() {
		
		let stepBinding = matching()
		
		given_stepBindings(
			stepBinding)
		
		when_executeStep(.Given, "text", Table(columns: ["col"]))
		
		XCTAssertEqual(stepBinding.passedParameters, BindingsParameters(
			table: Table(columns: ["col"])))
	}
	
	func test_oneMatchingBinding_evaluatedValuesIsSentToBinding() {
		let stepBinding = matching(evaluatedValues: ["42", "foo"])

		given_stepBindings(
			stepBinding)
		
		when_executeStep(.Given, "text")
		
		XCTAssertEqual(stepBinding.passedParameters, BindingsParameters(
			matchedParameters: ["42", "foo"]))
	}

	func test_oneMatchingBinding_tableAndEvaluatedValuesAreSentToBinding() {
		let stepBinding = matching(evaluatedValues: ["42", "foo"])
		
		given_stepBindings(
			stepBinding)
		
		when_executeStep(.Given, "text", Table(columns: ["col"]))
		
		XCTAssertEqual(stepBinding.passedParameters, BindingsParameters(
			table: Table(columns: ["col"]),
			matchedParameters: ["42", "foo"]))
	}

	// MARK:
	// MARK: Givens, whens and thens
	private func given_zeroStepBindings() {
		given_stepBindings([])
	}

	private func given_stepBindings(_ one: StepBinding) {
		given_stepBindings([one])
	}

	private func given_stepBindings(_ one: StepBinding, _ two: StepBinding) {
		given_stepBindings([one, two])
	}

	private func given_stepBindings(_ bindings: [StepBinding]) {
		mockBindingsRepository.stepBindings = bindings
	}
	
	private func when_executeStep(_ type: StepType, _ text: String, _ table: Table? = nil) {
		do {
			try instance().executeStep(.Given, text, table)
			
		} catch StepExecutionError.NoStepBindingFoundForStep(let stepText){
			stepNotFoundText = stepText
			
		} catch StepExecutionError.MoreThanOneStepBindingFoundForStep(let stepText){
			stepNotFoundText = stepText
		
		} catch {
			XCTFail("\(error)")
		}
	}

	private func then_shouldThrowStepNotFoundError(forText text: String) {
		XCTAssertEqual(stepNotFoundText, text)
	}

	private func then_shouldThrowMoreThanOneStepFoundError(forText text: String) {
		XCTAssertEqual(moreThanOneStepFoundText, text)
	}

	// MARK:
	// MARK: Factory methods 
	private func instance() -> TestRunner {
		return TestRunner(registry: bindingsRegistry)
	}
	
	private func matching(evaluatedValues: [String] = []) -> MockStepBinding {
		return MockStepBinding(matchesText: true, evaluatedValues: evaluatedValues)
	}

	private func nonMatching() -> MockStepBinding {
		return MockStepBinding(matchesText: false)
	}
}
