//
//  FetchSearchMedia.swift
//  Pulentunes
//
//  Created by Diego Alexander Salazar on 10/15/19.
//  Copyright © 2019 Diego Alexander Salazar. All rights reserved.
//

import Foundation

struct FetchSearchMedia {
    static let shared = FetchSearchMedia()
    
    let provider = NetworkProvider<iTunesEndPoint>()
    
    func search(text: String, media: String = "music", limit: Int = 100,
                completion: @escaping ClosureType<SearchGroup>, failure: @escaping Failure) {
        provider.request(.search(term: text, media: media, limit: limit),
                         model: SearchGroup.self,
                         completion: completion,
                         failure: failure)
    }
}

enum iTunesEndPoint: EndPointType {
    case search(term: String, media: String, limit: Int)
    
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    var path: String {
        return "/search"
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    var task: HTTPTask {
        switch self {
        case .search(let term, let media, let limit):
            return .requestParameters(bodyEncoding: .urlEncoding,
                                      urlParameters: ["term": term,
                                                      "media": media,
                                                      "limit": limit])
        }
    }
}
