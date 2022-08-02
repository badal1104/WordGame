//
//  WordPair.swift
//  WordGame
//
//  Created by Badal Yadav on 02/08/22.
//

import Foundation

struct WordPair: Codable {
    
    let english: String
    let spanish: String

    private enum CodingKeys: String, CodingKey {
        case english = "text_eng"
        case spanish = "text_spa"
    }
}
