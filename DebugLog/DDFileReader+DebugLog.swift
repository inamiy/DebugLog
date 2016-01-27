//
//  DDFileReader+DebugLog.swift
//  DebugLog
//
//  Created by Yasuhiro Inami on 2014/06/26.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

import Foundation

extension DDFileReader
{
    func readLogLine(index: Int) -> NSString!
    {
        var line: NSString!
        
        self.resetOffset()
        
        var lineNum = 0
        
        self.enumerateLinesUsingBlock { (currentLine, stop) in
            lineNum += 1
            if lineNum == index {
                line = currentLine
                stop = true
            }
        }
        
        let logFuncString = "LOG_OBJECT\\(.*?\\)" as NSString
        
        var range = line.rangeOfString(logFuncString as String, options: .RegularExpressionSearch)
        range.location += logFuncString.length-6
        range.length -= logFuncString.length-5
        
        line = line.substringWithRange(range).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return line
    }
}