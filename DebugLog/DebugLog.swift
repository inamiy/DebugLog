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
    static let _lock = NSObject()
    
    static var printHandler: (Any!, String, String, Int) -> Void = { body, filename, functionName, line in
        
        if body == nil {
            println("[\(filename).\(functionName):\(line)]")    // print functionName
            return
        }
        
        if let body = body as? String {
            if count(body) == 0 {
                println("") // print break
                return
            }
        }
        
        println("[\(filename):\(line)] \(body)")
    }
    
    static func print(_ body: Any! = nil, var filename: String = __FILE__, var functionName: String = __FUNCTION__, line: Int = __LINE__)
    {
#if DEBUG
    
        objc_sync_enter(_lock)
    
        filename = filename.lastPathComponent.stringByDeletingPathExtension
        self.printHandler(body, filename, functionName, line)
    
        objc_sync_exit(_lock)
    
#endif
    }
}

/// LOG() = prints __FUNCTION__
func LOG(filename: String = __FILE__, var functionName: String = __FUNCTION__, line: Int = __LINE__)
{
#if DEBUG
    
    DebugLog.print(nil, filename: filename, functionName: functionName, line: line)
    
#endif
}

/// LOG(...) = println
func LOG(body: Any, filename: String = __FILE__, var functionName: String = __FUNCTION__, line: Int = __LINE__)
{
#if DEBUG
    
    DebugLog.print(body, filename: filename, functionName: functionName, line: line)
    
#endif
}

/// LOG_OBJECT(myObject) = println("myObject = ...")
func LOG_OBJECT(body: Any, filename: String = __FILE__, var functionName: String = __FUNCTION__, line: Int = __LINE__)
{
#if DEBUG
    
    if let reader = DDFileReader(filePath: filename) {
        let logBody = "\(reader.readLogLine(line)) = \(body)"
        
        LOG(logBody, filename: filename, functionName: functionName, line: line)
    }
    
#endif
}

func LOG_OBJECT(body: AnyClass, filename: String = __FILE__, var functionName: String = __FUNCTION__, line: Int = __LINE__)
{
#if DEBUG
    
    let reader = DDFileReader(filePath: filename)
    
    let classInfo: DebugLog.ParsedClass = DebugLog.parseClass(body)
    let classString = classInfo.moduleName != nil ? "\(classInfo.moduleName!).\(classInfo.name)" : "\(classInfo.name)"
    
    LOG_OBJECT(classString, filename: filename, functionName: functionName, line: line)
    
    // comment-out: requires method name demangling
//    LOG_OBJECT("\(class_getName(body))", filename: filename, functionName: functionName, line: line)
    
#endif
}

