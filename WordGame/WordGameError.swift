//
//  WordGameError.swift
//  WordGame
//
//  Created by Badal Yadav on 05/08/22.
//

import Foundation

enum WordGameError: Error {
    case unableToReadFile
    case corruptData
    case decodingFail
    case other(message: String)
    
    var localizedDescription: String {
        var message: String = "Something went wrong, please try again later"
        
        switch self {
        case .unableToReadFile:
            message = "Problem in reading file, please validate it."
        case .corruptData:
            message = "Empty response data"
        case .decodingFail:
            message = "Unable to decode response object"
        case let .other(errorMessage):
            message = errorMessage
        }
        return message
    }
}
