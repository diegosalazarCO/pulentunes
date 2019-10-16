//
//  SearchSceneViewControllerTests.swift
//  Pulentunes
//
//  Created by Diego Alexander Salazar on 10/16/19.
//  Copyright (c) 2019 Diego Alexander Salazar. All rights reserved.
//

@testable import Pulentunes
import XCTest

class SearchSceneViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: SearchSceneViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    setupSearchSceneViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupSearchSceneViewController()
  {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    sut = storyboard.instantiateViewController(withIdentifier: "SearchSceneViewController") as? SearchSceneViewController
  }
  
  func loadView()
  {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test doubles
  
  class SearchSceneBusinessLogicSpy: SearchSceneInteractorProtocol {
    var searchCalled = false
    func search(text: String) {
        searchCalled = true
    }
  }
  
  // MARK: Tests
  
  func testShouldDoSomethingWhenViewIsLoaded()
  {
    // Given
    let spy = SearchSceneBusinessLogicSpy()
    sut.interactor = spy
    
    // When
    loadView()
    
    // Then
    XCTAssertTrue(spy.searchCalled, "viewDidLoad() should ask the interactor to do search")
  }
  
  func test_Items_DisplayList_ShouldDisplayGivenViewModel()
  {
    // Given
    let mockItem = SearchListViewModel.Item(title: "mock", coverImage: nil, artist: "mockArtist", album: "mockAlbum")
    let viewModel = [mockItem]
    
    // When
    loadView()
    sut.displayList(withViewModel: viewModel)
    
    // Then
    XCTAssertEqual(sut.songsListViewModel[0].title, "mock", "displayList(viewModel:) should update the titles")
    XCTAssertEqual(sut.songsListViewModel[0].artist, "mockArtist", "displayList(viewModel:) should update the titles")
    XCTAssertEqual(sut.songsListViewModel[0].album, "mockAlbum", "displayList(viewModel:) should update the titles")
  }
}
