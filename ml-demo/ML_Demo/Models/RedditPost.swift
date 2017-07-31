//
//  RedditPost.swift
//  ML_Demo
//
//  Created by Michael Caulley on 6/9/17.
//  Copyright © 2017 Michael Caulley. All rights reserved.
//

import Vision

struct RedditPost {
    
    let title: String
    let url: String
    let score: Int
    
    /// Clickbaityness is a 0.0 - 1.0 value, with 1.0 being the most clickbaity
    let clickBaityness: Double
    
    static func calculateClickBaitPercentageFor(_ headline: String) -> Double? {
        let cleanedHeadlineArray = headline.clean.words
        let indices = Vocab.wordsToIndices(words: cleanedHeadlineArray)
        let input = Vocab.padSequence(sequence: indices, maxLength: 20)
        let model = clickbait_model()
        let data = input.reduce([], +)
        
        guard let mlMultiArray = try? MLMultiArray(shape:[20,1,1],
                                                   dataType:MLMultiArrayDataType.int32) else {
                                                    fatalError("Unexpected runtime error. MLMultiArray")
        }
        
        for (index, element) in data.enumerated() {
            mlMultiArray[index] = NSNumber(integerLiteral: element)
        }
        
        if let result = try? model.prediction(headline: mlMultiArray) {
            return result.clickbaityness[0] as? Double
        } else {
            return nil
        }
    }
}
