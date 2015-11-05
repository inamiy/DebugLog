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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool
    {
#if false
        DebugLog.printHandler = { body, filename, functionName, line in
            println(body)
        }
#endif
        
        LOG()                   // prints __FUNCTION__
        LOG("")                 // prints break
        LOG("=== DEBUG ===")    // LOG = DebugLog.print
        
        LOG_OBJECT(self)        // LOG_OBJECT(argument) = prints argument name
        LOG_OBJECT(self.dynamicType)
        LOG_OBJECT(AppDelegate.self)
        
        // TODO: returns (Metatype)
        //LOG_OBJECT(Int.self)
        
        let int = 3
        LOG_OBJECT(int)
        
        let float: Float = 3.0
        LOG_OBJECT(float)
        
        let rect: CGRect = CGRect(x: 10, y: 20, width: 30, height: 40)
        LOG_OBJECT(rect)
        
        let range: Range = 1 ..< 3
        LOG_OBJECT(range)
        
        let nsRange: NSRange = NSMakeRange(2, 4)
        LOG_OBJECT(nsRange)
        
        let transform = CGAffineTransformIdentity
        LOG_OBJECT(transform)
        
        let transform3D = CATransform3DIdentity
        LOG_OBJECT(transform3D)
        
        let currentThread = NSThread.currentThread()
        LOG(currentThread)
        
        LOG("")
        
        func testOptional()
        {
            LOG()
            
            var optional: Int? = nil
            LOG_OBJECT(optional)
            
            optional = 111
            LOG_OBJECT(optional)
            
            var impOptional: String! = nil
            //LOG_OBJECT(impOptional)   // comment-out: accessing impOptional=nil will crash
            
            impOptional = "hoge"
            LOG_OBJECT(impOptional)
        }
        
        testOptional()
        LOG("")
        
        func testDoubleOptional()
        {
            LOG()
            
            var optional2: Int?? = nil
            LOG_OBJECT(optional2)
            
            optional2 = Optional(nil)   // != nil
            LOG_OBJECT(optional2)
            
            optional2 = 111
            LOG_OBJECT(optional2)
            
            var impOptional2: String!! = nil
            //LOG_OBJECT(impOptional2)  // comment-out: accessing impOptional=nil will crash
            
            impOptional2 = Optional(nil)
            LOG_OBJECT(impOptional2)
            
            impOptional2 = "hoge"
            LOG_OBJECT(impOptional2)
        }
        
        testDoubleOptional()
        LOG("")
        
        func testAsync()
        {
            LOG()
            
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
        }
        
        testAsync()
        LOG("")
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        self.window?.rootViewController = UIViewController()
        
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

