//
//  DebugLog+Printable.swift
//  DebugLog
//
//  Created by Yasuhiro Inami on 2014/06/22.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

import Foundation
import CoreGraphics
import QuartzCore

extension Range : Printable, DebugPrintable
{
    var description: String
    {
        return "(\(startIndex)..\(endIndex))"
    }
    
    var debugDescription: String
    {
        return self.description
    }
}

//
// TODO: 
// Some C-structs (e.g. CGAffineTransform, CATransform3D) + Printable don't work well in Xcode6-beta2
//
extension CGAffineTransform : Printable, DebugPrintable
{
    var description: String
    {
//        return NSStringFromCGAffineTransform(self) // comment-out: requires UIKit
        return "[\(a), \(b);\n \(c), \(d);\n \(tx), \(ty)]"
    }
    
    var debugDescription: String
    {
        return self.description
    }
}

extension CATransform3D : Printable, DebugPrintable
{
    var description: String
    {
        return "[\(m11) \(m12) \(m13) \(m14);\n \(m21) \(m22) \(m23) \(m24);\n \(m31) \(m32) \(m33) \(m34);\n \(m41) \(m42) \(m43) \(m44)]"
    }
    
    var debugDescription: String
    {
        return self.description
    }
}