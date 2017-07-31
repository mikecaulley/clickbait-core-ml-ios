//
//  StringExtensions.swift
//  ML_Demo
//
//  Created by Mike Caulley on 6/29/17.
//  Copyright © 2017 Mike Caulley. All rights reserved.
//

import Foundation

extension String {
    
    /// Returns an array of Strings based on whitespace separation
    var words: [String]  {
        var array = [String]()
        var foundString = ""
        for char in self.characters {
            if String(char).rangeOfCharacter(from: CharacterSet.punctuationCharacters) != nil {
                if foundString != "" { array.append(foundString) }
                foundString = String(char)
                array.append(foundString)
                foundString = ""
            }
            else if String(char) == " " {
                array.append(foundString)
                foundString = ""
            }
            else if Int(String(char)) != nil {
                foundString = String(char)
                array.append(foundString)
                foundString = ""
            } else {
                foundString += String(char)
            }
        }
        return array.filter{!$0.isEmpty}
    }
    
    /// Returns the lowecased string with spaces around any punctuation
    var clean: String {
        var text = self.lowercased()
        let punctuationChars = text.punctuation
        for char in punctuationChars {
            text = text.replacingOccurrences(of: char, with: " " + char + " ")
        }
        text = text.condensedWhitespace
        return text
    }
    
    /// Returns an array of punctuation characters in the string
    var punctuation: [String] {
        var punctuationChars = [String]()
        for char in self {
            if NSCharacterSet.punctuationCharacters.contains(char.unicodeScalars.first!) {
                punctuationChars.append(String(char))
            }
        }
        return punctuationChars
    }
    
    /// Combines multiple whitespaces into a single whitespace
    var condensedWhitespace: String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
