//
//  DataParser.swift
//  WordGame
//
//  Created by Badal Yadav on 02/08/22.
//

import Foundation
protocol DataParserProtocol {
    func parseJson<T: Codable>(jsonResponse: T.Type, data: Data) throws -> T
}
struct DataParser: DataParserProtocol {
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func parseJson<T: Codable>(jsonResponse: T.Type, data: Data) throws -> T {
        do {
            let wordPairList = try decoder.decode(jsonResponse, from: data)
            return wordPairList
        } catch {
            throw WordGameError.decodingFail
        }
    }
}
