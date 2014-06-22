//
//  DebugLogDemoTests.swift
//  DebugLogDemoTests
//
//  Created by Yasuhiro Inami on 2014/06/22.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

import XCTest
import CoreGraphics
import QuartzCore

class DebugLogTests: XCTestCase {
    
    override func setUp()
    {
        super.setUp()
        
        println()
        println("===== SET UP =====")
#if DEBUG
        println("=== DEBUG MODE ===")
#endif
    }
    
    override func tearDown()
    {
        println()
        println("===== TEAR DOWN =====")
        
        super.tearDown()
    }
    
    func testPrintlnPerformance()
    {
        self.measureBlock() {
            for _ in 0..1000 {
#if DEBUG
                println("hoge")
#endif
            }
        }
    }
    
    func testDebugLogPerformance()
    {
        self.measureBlock() {
            for _ in 0..1000 {
                LOG("hoge")
            }
        }
    }
    
}
