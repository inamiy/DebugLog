DebugLog
========

DebugLog macro alternative for Swift, replacing old C macros e.g. [Log-YIHelper](https://github.com/inamiy/Log-YIHelper/blob/master/NSLog%2BYIHelper.h).


How to use
----------

1. Drag & drop `DebugLog.all.swift` to your Xcode project.
2. Set `OTHER_SWIFT_FLAGS = -D DEBUG` in your Xcode project target.

```
LOG()

LOG("Hello World!")

LOG_OBJECT(self.window)
LOG_OBJECT(AppDelegate.self)

let int: Int = 3
LOG_OBJECT(int)

let float: Float = 3.0
LOG_OBJECT(float)

let rect: CGRect = CGRect(x: 10, y: 20, width: 30, height: 40)
LOG_OBJECT(rect)

let range: Range = 1...3
LOG_OBJECT(range)

let nsRange: NSRange = NSMakeRange(2, 4)
LOG_OBJECT(nsRange)

let optional: Int? = nil
LOG_OBJECT(optional)
```

will display:

```
2015-12-12 18:01:00.375 [AppDelegate.application(_:didFinishLaunchingWithOptions:):24]
2015-12-12 18:01:00.376 [AppDelegate:26] Hello World!
2015-12-12 18:01:00.380 [AppDelegate:28] self.window = nil
2015-12-12 18:01:00.381 [AppDelegate:29] AppDelegate.self = DebugLogDemo.AppDelegate
2015-12-12 18:01:00.381 [AppDelegate:32] int = 3
2015-12-12 18:01:00.382 [AppDelegate:35] float = 3.0
2015-12-12 18:01:00.382 [AppDelegate:38] rect = (10.0, 20.0, 30.0, 40.0)
2015-12-12 18:01:00.383 [AppDelegate:41] range = 1..<4
2015-12-12 18:01:00.383 [AppDelegate:44] nsRange = (2,4)
2015-12-12 18:01:00.384 [AppDelegate:47] optional = nil
```
Note
----------
`LOG_OBJECT` does not print variable names on Devices. Output would look like this.

  ```
  2015-12-12 18:01:00.375 [AppDelegate.application(_:didFinishLaunchingWithOptions:):24]
  2015-12-12 18:01:00.376 [AppDelegate:26] Hello World!
  2015-12-12 18:01:00.380 [AppDelegate:28] nil
  2015-12-12 18:01:00.381 [AppDelegate:29] DebugLogDemo.AppDelegate
  2015-12-12 18:01:00.381 [AppDelegate:32] 3
  2015-12-12 18:01:00.382 [AppDelegate:35] 3.0
  2015-12-12 18:01:00.382 [AppDelegate:38] (10.0, 20.0, 30.0, 40.0)
  2015-12-12 18:01:00.383 [AppDelegate:41] 1..<4
  2015-12-12 18:01:00.383 [AppDelegate:44] (2,4)
  2015-12-12 18:01:00.384 [AppDelegate:47] nil
  ```

For further customization, change default `Debug.printHandler` to print in any format & logging destination.

More information is available at [Qiita](http://qiita.com/inamiy/items/c4e137309725485dc195) (in Japanese).
