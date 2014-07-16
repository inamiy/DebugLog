//
//  AppDelegate.swift
//  DebugLogDemo
//
//  Created by Yasuhiro Inami on 2014/06/22.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
#if false
        DebugLog.printHandler = { body, filename, functionName, line in
            println(body)
        }
#endif
        
        LOG()           // prints __FUNCTION__
        
        LOG("")         // prints break
        
        LOG("=== DEBUG ===")    // LOG = DebugLog.print
        
        LOG_OBJECT(self)
        LOG_OBJECT(AppDelegate.self)
        
        // TODO: returns (Metatype)
//        LOG_OBJECT(Int.self)
        
        let int = 3
        LOG_OBJECT(int)         // LOG_OBJECT(argument) = prints argument name
        
        let float: Float = 3.0
        LOG_OBJECT(float)
        
        let rect: CGRect = CGRect(x: 10, y: 20, width: 30, height: 40)
        LOG_OBJECT(rect)
        
        let range: Range = 1 ..< 3
        LOG_OBJECT(range)
        
        let nsRange: NSRange = NSMakeRange(2, 4)
        LOG_OBJECT(nsRange)
        
        let optional: Int? = nil
        LOG_OBJECT(optional)
        
        // comment-out: some C-structs don't work well, use dump() instead
//        let transform = CGAffineTransformIdentity
//        LOG_OBJECT(transform)
//        let transform3D = CATransform3DIdentity
//        LOG_OBJECT(transform3D)
        
        // comment-out: segmentation fault in Xcode6-beta2
//        let currentThread = NSThread.currentThread
//        LOG(currentThread)
        
        
        // dispatch_group_async test
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let group = dispatch_group_create()
        
        for i in 0...9 {
            dispatch_group_async(group, queue) {
                LOG("dispatch_group_async \(i)")
            }
        }
        dispatch_group_notify(group, queue) {
            LOG("dispatch_group_async done")
        }
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        LOG()
    }

    func applicationDidEnterBackground(application: UIApplication) {
        LOG()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        LOG()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        LOG()
    }

    func applicationWillTerminate(application: UIApplication) {
        LOG()
    }

}

