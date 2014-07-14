//
//  DebugLog.swift
//  DebugLog
//
//  Created by Yasuhiro Inami on 2014/06/22.
//  Copyright (c) 2014年 Inami Yasuhiro. All rights reserved.
//

import Foundation

struct DebugLog
{
    static var printHandler: (Any!, String!, String!, Int) -> Void = { body, filename, functionName, line in
        
        if !body {
            println("[\(filename).\(functionName):\(line)]")    // print functionName
            return
        }
        
        if let body_ = body as? String {
            if countElements(body_) == 0 {
                println("") // print break
            }
            else {
                println("[\(filename):\(line)] \(body)")
            }
        }
        else {
            println("[\(filename):\(line)] \(body)")
        }
    }
    
    static func print(_ body: Any! = nil, var filename: String = __FILE__, var functionName: String = __FUNCTION__, line: Int = __LINE__)
    {
#if DEBUG
    
        filename = filename.lastPathComponent.stringByDeletingPathExtension
        
        self.printHandler(body, filename, functionName, line)
    
#endif
    }
}

func LOG(_ body: Any! = nil, filename: String = __FILE__, var functionName: String = __FUNCTION__, line: Int = __LINE__)
{
#if DEBUG
    
    DebugLog.print(body, filename: filename, functionName: functionName, line: line)
    
#endif
}

func LOG_OBJECT(body: Any!, filename: String = __FILE__, var functionName: String = __FUNCTION__, line: Int = __LINE__)
{
#if DEBUG
    
    let reader = DebugLog.FileReader(filePath: filename)
    
    let logBody = "\(reader.readLogLine(line)) = \(body)"
    
    LOG(logBody, filename: filename, functionName: functionName, line: line)
    
#endif
}

func LOG_OBJECT(body: AnyClass, filename: String = __FILE__, var functionName: String = __FUNCTION__, line: Int = __LINE__)
{
#if DEBUG
    
    let reader = DebugLog.FileReader(filePath: filename)
    
    let classInfo: DebugLog.ParsedClass = DebugLog.parseClass(body)
    let classString = classInfo.moduleName ? "\(classInfo.moduleName).\(classInfo.name)" : "\(classInfo.name)"
    
    LOG_OBJECT(classString, filename: filename, functionName: functionName, line: line)
    
    // comment-out: requires method name demangling
//    LOG_OBJECT("\(class_getName(body))", filename: filename, functionName: functionName, line: line)
    
#endif
}

extension DebugLog.FileReader
{
    func readLogLine(index: Int) -> NSString!
    {
        var line: NSString!
        
        self.resetOffset()
        
        var lineNum = 0
        
        self.enumerateLinesUsingBlock { (currentLine, stop) in
            lineNum++
            if lineNum == index {
                line = currentLine
                stop = true
            }
        }
        
        let logFuncString = "LOG_OBJECT\\(.*?\\)" as NSString
        
        var range = line.rangeOfString(logFuncString, options: .RegularExpressionSearch)
        range.location += logFuncString.length-6
        range.length -= logFuncString.length-5
        
        line = line.substringWithRange(range).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return line
    }
}