//
//  SearchScenePresenterTests.swift
//  Pulentunes
//
//  Created by Diego Alexander Salazar on 10/16/19.
//  Copyright (c) 2019 Diego Alexander Salazar. All rights reserved.
//

@testable import Pulentunes
import XCTest

class SearchScenePresenterTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: SearchScenePresenter!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupSearchScenePresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupSearchScenePresenter()
  {
    sut = SearchScenePresenter()
  }
  
  // MARK: Test doubles
  
  class SearchSceneDisplayLogicSpy: SearchSceneViewProtocol
  {
    var displaySomethingCalled = false
    func displayList(withViewModel viewModel: [SearchListViewModel.Item]) {
        displaySomethingCalled = true
    }
  }
  
  // MARK: Tests
  
  func testPresentResults()
  {
    // Given
    let spy = SearchSceneDisplayLogicSpy()
    sut.viewController = spy
    let mockresults = [SearchListViewModel.Item]()
    
    // When
    sut.presentResults(results: mockresults)
    
    // Then
    XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
  }
}
