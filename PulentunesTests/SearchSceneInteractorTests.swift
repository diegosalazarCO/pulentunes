//
//  SearchSceneInteractorTests.swift
//  Pulentunes
//
//  Created by Diego Alexander Salazar on 10/16/19.
//  Copyright (c) 2019 Diego Alexander Salazar. All rights reserved.
//

@testable import Pulentunes
import XCTest

class SearchSceneInteractorTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: SearchSceneInteractor!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupSearchSceneInteractor()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupSearchSceneInteractor()
  {
    sut = SearchSceneInteractor()
  }
  
  // MARK: Test doubles
  
  class SearchScenePresentationLogicSpy: SearchScenePresentationProtocol {
    var presentResultsCalled = false
    func presentResults(results: [SearchListViewModel.Item]) {
        presentResultsCalled = true
    }
  }
  
  // MARK: Tests
  
  func testSearchText()
  {
    // Given
    let spy = SearchScenePresentationLogicSpy()
    sut.presenter = spy
    
    // When
    sut.search(text: "mocktext")
    
    // Then
    XCTAssertTrue(spy.presentResultsCalled, "doSomething(request:) should ask the presenter to format the result")
  }
}
