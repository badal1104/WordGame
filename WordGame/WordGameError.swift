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
        var message: String = WordGameError.generalMessage
        switch self {
        case .unableToReadFile:
            message = WordGameError.unableToReadFileMessage
        case .corruptData:
            message = WordGameError.corruptDataMessage
        case .decodingFail:
            message = WordGameError.decodingFailMessage
        case let .other(errorMessage):
            message = errorMessage
        }
        return message
    }
}
