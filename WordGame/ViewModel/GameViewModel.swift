//
//  GameViewModel.swift
//  WordGame
//
//  Created by Badal Yadav on 02/08/22.
//

import Foundation

final class GameViewModel {
    let fileReader: FileReaderProtocol
    init(fileReader: FileReaderProtocol =  FileReader()) {
        self.fileReader =  fileReader
    }
    
    func getFileData() {
        self.fileReader.fetchDataFromFile(with: WordGameConstant.fileName) { (result: Result<[WordPair], WordGameError>) in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
