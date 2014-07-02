DebugLog
========

DebugLog macro alternative for Swift, replacing old C macros e.g. [Log-YIHelper](https://github.com/inamiy/Log-YIHelper/blob/master/NSLog%2BYIHelper.h).


How to use
----------

Set `OTHER_SWIFT_FLAGS = -D DEBUG` in your Xcode project target.

```
LOG()

LOG("Hello World!")

LOG_OBJECT(self.window)
LOG_OBJECT(AppDelegate.self)

let int: Integer = 3
LOG_OBJECT(int)

let float: Float = 3.0
LOG_OBJECT(float)

let rect: CGRect = CGRect(x: 10, y: 20, width: 30, height: 40)
LOG_OBJECT(rect)

let range: Range = 1..3
LOG_OBJECT(range)

let nsRange: NSRange = NSMakeRange(2, 4)
LOG_OBJECT(nsRange)

let optional: Int? = nil
LOG_OBJECT(optional)
```

will display:

```
[AppDelegate.application(_:didFinishLaunchingWithOptions:):43] 
[AppDelegate:45] Hello World!
[AppDelegate:47] self.window = <UIWindow: 0xb50ab50; frame = (0 0; 320 480); gestureRecognizers = <NSArray: 0xb50b3c0>; layer = <UIWindowLayer: 0xb50adc0>>
[AppDelegate:48] AppDelegate.self = DebugLogDemo.AppDelegate
[AppDelegate:51] int = 3
[AppDelegate:54] float = 3.0
[AppDelegate:57] rect = (10.0,20.0,30.0,40.0)
[AppDelegate:60] range = (1..3)
[AppDelegate:63] nsRange = (2,4)
[AppDelegate:66] optional = nil
```

More information is available at [Qiita](http://qiita.com/inamiy/items/c4e137309725485dc195) (in Japanese).
