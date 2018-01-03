//
//  Result.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/29.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation

enum Result {
    case Success
    case Failure(Error)
}

enum Error {
    case UnknownError(String)
}
