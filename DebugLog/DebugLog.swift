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
        if let body_ = body as? String {
            if countElements(body_) == 0 {
                println("[\(filename).\(functionName):\(line)] \(body)")
            }
            else {
                println("[\(filename):\(line)] \(body)")
            }
        }
        else {
            println("[\(filename):\(line)] \(body)")
        }
    }
    
    static func print(_ body: Any! = "", var filename: String = __FILE__, var functionName: String = __FUNCTION__, line: Int = __LINE__, functionName2: String = __FUNCTION__)
    {
#if DEBUG
    
        //
        // __FUNCTION__ workaround (in Xcode6-beta2)
        // see also: https://github.com/DaveWoodCom/XCGLogger/blob/master/XCGLogger/XCGLogger/XCGLogger.swift#L10-L21
        //
        if functionName != functionName2 {
            let range: Range = functionName2.rangeOfString(functionName, options: .LiteralSearch)
            functionName = functionName2.stringByReplacingCharactersInRange(range, withString: "")
        }
        
        filename = filename.lastPathComponent.stringByDeletingPathExtension
        
        self.printHandler(body, filename, functionName, line)
    
#endif
    }
}

func LOG(_ body: Any! = "", filename: String = __FILE__, var functionName: String = __FUNCTION__, line: Int = __LINE__, functionName2: String = __FUNCTION__)
{
#if DEBUG
    
    DebugLog.print(body, filename: filename, functionName: functionName, line: line, functionName2: functionName2)
    
#endif
}

func LOG_OBJECT(_ body: Any! = "", filename: String = __FILE__, var functionName: String = __FUNCTION__, line: Int = __LINE__, functionName2: String = __FUNCTION__)
{
#if DEBUG
    
    let reader = DebugLog.FileReader(filePath: filename)
    
    let logBody = "\(reader.readLogLine(line)) = \(body)"
    
    LOG(logBody, filename: filename, functionName: functionName, line: line, functionName2: functionName2)
    
#endif
}

func LOG_OBJECT(body: AnyClass, filename: String = __FILE__, var functionName: String = __FUNCTION__, line: Int = __LINE__, functionName2: String = __FUNCTION__)
{
#if DEBUG
    
    let reader = DebugLog.FileReader(filePath: filename)
    
    let classInfo: DebugLog.ParsedClass = DebugLog.parseClass(body)
    let classString = classInfo.moduleName ? "\(classInfo.moduleName).\(classInfo.name)" : "\(classInfo.name)"
    
    LOG_OBJECT(classString, filename: filename, functionName: functionName, line: line, functionName2: functionName2)
    
    // comment-out: requires method name demangling
//    LOG_OBJECT("\(class_getName(body))", filename: filename, functionName: functionName, line: line, functionName2: functionName2)
    
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
                return
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