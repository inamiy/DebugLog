//
//  DebugLog+FileReader.swift
//  DebugLog
//
//  Created by Yasuhiro Inami on 2014/06/26.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

import Foundation

extension DebugLog
{
    //
    // Swift port of DDFileReader by Dave DeLong
    // https://github.com/inamiy/DDFileReader
    //
    // objective c - How to read data from NSFileHandle line by line? - Stack Overflow
    // http://stackoverflow.com/a/3711079/666371
    //
    class FileReader
    {
        var lineDelimiter = "\n"
        var chunkSize = 128
        
        let filePath: NSString!
        
        let _fileHandle: NSFileHandle!
        let _totalFileLength: CUnsignedLongLong!
        var _currentOffset: CUnsignedLongLong = 0
        
        init?(filePath: NSString!)
        {
            if let fileHandle = NSFileHandle(forReadingAtPath: filePath) {
                self.filePath = filePath
                self._fileHandle = NSFileHandle(forReadingAtPath: filePath)
                self._totalFileLength = self._fileHandle.seekToEndOfFile()
            }
            else {
                return nil
            }
        }
        
        deinit
        {
            self._fileHandle.closeFile()
        }
        
        func readLine() -> NSString!
        {
            if self._currentOffset >= self._totalFileLength {
                return nil
            }
            
            self._fileHandle.seekToFileOffset(self._currentOffset)
            let newLineData = self.lineDelimiter.dataUsingEncoding(NSUTF8StringEncoding)
            let currentData = NSMutableData()
            var shouldReadMore = true
            
            autoreleasepool {
                
                while shouldReadMore {
                    
                    if self._currentOffset >= self._totalFileLength {
                        break
                    }
                    
                    var chunk = self._fileHandle.readDataOfLength(self.chunkSize)
                    
                    let newLineRange = self._rangeOfData(chunk, dataToFind: newLineData!)
                    
                    if newLineRange.location != NSNotFound {
                        chunk = chunk.subdataWithRange(NSMakeRange(0, newLineRange.location+newLineData!.length))
                        shouldReadMore = false
                    }
                    currentData.appendData(chunk)
                    
                    self._currentOffset += CUnsignedLongLong(chunk.length)
                    
                }
                
            }
            
            let line = NSString(data: currentData, encoding:NSUTF8StringEncoding)
            
            return line
        }
        
        func readTrimmedLine() -> NSString!
        {
            return self.readLine().stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: self.lineDelimiter))
        }
        
        func enumerateLinesUsingBlock(closure: (NSString!, inout Bool) -> Void)
        {
            var line: NSString! = nil
            var stop = false
            while stop == false {
                line = self.readLine()
                if line == nil { break }
                
                closure(line, &stop)
            }
        }
        
        func resetOffset()
        {
            self._currentOffset = 0
        }
        
        func _rangeOfData(data: NSData, dataToFind: NSData) -> NSRange
        {
            var searchIndex = 0
            var foundRange = NSRange(location: NSNotFound, length: dataToFind.length)
            
            for index in 0 ..< data.length {
                
                let bytes_ = UnsafeBufferPointer(start: UnsafePointer<CUnsignedChar>(data.bytes), count: data.length)
                let searchBytes_ = UnsafeBufferPointer(start: UnsafePointer<CUnsignedChar>(dataToFind.bytes), count: data.length)
                
                if bytes_[index] == searchBytes_[searchIndex] {
                    if foundRange.location == NSNotFound {
                        foundRange.location = index
                    }
                    searchIndex++
                    if searchIndex >= dataToFind.length {
                        return foundRange
                    }
                }
                else {
                    searchIndex = 0
                    foundRange.location = NSNotFound
                }
                
            }
            return foundRange
        }
    }
}