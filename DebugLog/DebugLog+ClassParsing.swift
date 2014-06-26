//
//  DebugLog+ClassParsing.swift
//  DebugLog
//
//  Created by Yasuhiro Inami on 2014/06/26.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

import Foundation

// Swift and Objective-C Class Parsing by @jpsim
// https://gist.github.com/jpsim/1b86d116808cb4e9bc30
extension DebugLog
{
    enum ClassType {
        case Swift, ObjectiveC
        
        func toString() -> String {
            switch self {
            case .Swift:
                return "Swift"
            case .ObjectiveC:
                return "Objective-C"
            }
        }
    }

    struct ParsedClass {
        let type: ClassType
        let name: String
        
        let mangledName: String?
        let moduleName: String?
    }

    static func _substr(str: String, range: Range<Int>) -> String {
        let startIndex = advance(str.startIndex, range.startIndex)
        let endIndex = advance(startIndex, range.endIndex)
        
        return str[Range(start: startIndex, end: endIndex)]
    }

    static func parseClass(aClass: AnyClass) -> ParsedClass {
        // Swift mangling details found here: http://www.eswick.com/2014/06/inside-swift
        
        let originalName = NSStringFromClass(aClass)
        
        if !originalName.hasPrefix("_T") {
            // Not a Swift symbol
            return ParsedClass(type: ClassType.ObjectiveC,
                name: originalName,
                mangledName: nil,
                moduleName: nil)
        }
        
        let originalNameLength = originalName.utf16count
        var cursor = 4
        var substring = _substr(originalName, range: cursor..originalNameLength-cursor)
        
        // Module
        let moduleLength = substring.bridgeToObjectiveC().integerValue
        let moduleLengthLength = "\(moduleLength)".utf16count
        let moduleName = _substr(substring, range: moduleLengthLength..moduleLength)
        
        // Update cursor and substring
        cursor += moduleLengthLength + moduleName.utf16count
        substring = _substr(originalName, range: cursor..originalNameLength-cursor)
        
        // Class name
        let classLength = substring.bridgeToObjectiveC().integerValue
        let classLengthLength = "\(classLength)".utf16count
        let className = _substr(substring, range: classLengthLength..classLength)
        
        return ParsedClass(type: ClassType.Swift,
            name: className,
            mangledName: originalName,
            moduleName: moduleName)
    }
    
}