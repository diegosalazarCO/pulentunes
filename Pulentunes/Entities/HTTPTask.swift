//
//  HTTPTask.swift
//  Pulentunes
//
//  Created by Diego Alexander Salazar on 10/15/19.
//  Copyright © 2019 Diego Alexander Salazar. All rights reserved.
//

import Foundation

public enum HTTPTask {
    case request
    case requestParameters(bodyEncoding: ParameterEncoding, urlParameters: Parameters?)
}
