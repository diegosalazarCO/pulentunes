//
//  SearchSceneInteractor.swift
//  Pulentunes
//
//  Created by Diego Alexander Salazar on 10/15/19.
//  Copyright (c) 2019 Diego Alexander Salazar. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchSceneInteractorProtocol {
    func search()
}

protocol SearchSceneDataStore {
  //var name: String { get set }
}

class SearchSceneInteractor: SearchSceneInteractorProtocol, SearchSceneDataStore {
    var presenter: SearchScenePresentationProtocol?
    var worker: SearchSceneWorker?

    // MARK: Do something
  
    func doSomething() {
        worker = SearchSceneWorker()
        worker?.doSomeWork()

        //let response = SearchScene.Something.Response()
        //presenter?.presentSomething(response: response)
    }
    
    func search() {
        let fetchSearch = FetchSearchMedia.shared
        fetchSearch.search(text: "love", completion: { (result) in
            print(result)
        }) { (error) in
            print(error)
        }
    }
}
