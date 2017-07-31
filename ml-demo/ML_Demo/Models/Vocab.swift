//
//  Vocab.swift
//  ML_Demo
//
//  Created by Mike Caulley on 6/30/17.
//  Copyright © 2017 Mike Caulley. All rights reserved.
//

import Foundation

class Vocab {    
    static var vocabArray: [String]?
    
    static func wordsToIndices(words: [String]) -> [Int] {
        if (vocabArray == nil) {
            loadVocabFile()
        }
        
        var indices = [Int]()
        for word in words {
            if let index = vocabArray?.index(of: word) {
                indices.append(Int(index))
            } else if let UNKIndex = vocabArray?.index(of: "<UNK>") {
                indices.append(Int(UNKIndex))
            }
        }
        return indices
    }
    
    static func padSequence(sequence: [Int], maxLength: Int) -> [[Int]]{
        if sequence.count > maxLength {
            let paddedSequence = sequence[0..<maxLength]
            return [Array(paddedSequence)]
        } else if sequence.isEmpty {
            return [Array((0 ... maxLength).map { _ in 0 })]
        } else {
            var paddedSequence = Array((0..<maxLength - sequence.count).map { _ in 0 })
            paddedSequence.append(contentsOf: sequence)
            return [paddedSequence]
        }
    }
    
    static func loadVocabFile() {
        do {
            if let path = Bundle.main.path(forResource: "vocabulary", ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                Vocab.vocabArray = data.components(separatedBy: "\n")
            }
        } catch let err as NSError {
            print(err)
        }
    }
}
