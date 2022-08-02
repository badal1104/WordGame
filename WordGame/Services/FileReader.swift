//
//  FileReader.swift
//  WordGame
//
//  Created by Badal Yadav on 02/08/22.
//

import Foundation

protocol FileReaderProtocol {
    func fetchDataFromFile<T: Codable>(with fileName: String, completionHandler: @escaping ((Result<T, WordGameError>) -> Void))
}

enum WordGameError: Error {
    case unableToReadFile
    case corruptData
    case decodingFail
    case other(message: String)
}

struct FileReader: FileReaderProtocol {
    
    private let dataParser: DataParserProtocol
    
    init(dataParser: DataParserProtocol = DataParser()) {
        self.dataParser = dataParser
    }
    
    func fetchDataFromFile<T: Codable>(with fileName: String, completionHandler: (Result<T, WordGameError>) -> Void) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            completionHandler(.failure(.unableToReadFile))
            return
            
        }
        guard let data = try? Data(contentsOf: url) else {
            completionHandler(.failure(.corruptData))
            return
        }
        do {
            let wordList = try dataParser.parseJson(jsonResponse: T.self, data: data)
            completionHandler(.success(wordList))
        } catch {
            completionHandler(.failure(.decodingFail))
        }
    }
    
}
