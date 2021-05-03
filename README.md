# maps_example

An example of `google_maps_flutter` where taking a screenshot of the map causes the app to crash.

## Building Instructions

Create `ios/Runner/Constants.swift` with content such as:

```
class Constants {
    static let GMS_API_KEY : String = "<google API key>"
}
```

## Crash Reproduction Steps

The test case has two scenarios: one that causes a native crash, and one that successfully creates a screenshot without crashing.

### Scenario 1: No Crash

1. Run the app
2. Scroll down until the map is visible
3. Scroll back up until the **Snapshot** button is visible
4. Press the **Snapshot** button
5. Observe a toast indicating where the file was written to disk.

### Scenario 2: Crash

1. Run the app (if it was already running, be sure to restart)
2. Without scrolling, press the **Snapshot** button
3. Scroll down until the map would appear
4. Observe that the app crashes with a native stack trace similar to:

```
2021-05-03 07:06:36.715915-0700 Runner[4079:9685150] *** Assertion failure in -[FlutterStandardTypedData initWithData:type:], FlutterStandardCodec.mm:175
2021-05-03 07:06:36.723285-0700 Runner[4079:9685150] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Data cannot be nil'
*** First throw call stack:
(
	0   CoreFoundation                      0x00007fff20421af6 __exceptionPreprocess + 242
	1   libobjc.A.dylib                     0x00007fff20177e78 objc_exception_throw + 48
	2   CoreFoundation                      0x00007fff2042191f +[NSException raise:format:] + 0
	3   Foundation                          0x00007fff2077156a -[NSAssertionHandler handleFailureInMethod:object:file:lineNumber:description:] + 191
	4   Flutter                             0x0000000106d2efba -[FlutterStandardTypedData initWithData:type:] + 264
	5   Flutter                             0x0000000106d2eea6 +[FlutterStandardTypedData typedDataWithData:type:] + 47
	6   Runner                              0x00000001059823dd -[FLTGoogleMapController onMethodCall:result:] + 4349
	7   Runner                              0x0000000105980ec5 __75-[FLTGoogleMapController initWithFrame:viewIdentifier:arguments:registrar:]_block_invoke + 165
	8   Flutter                             0x0000000106d2cfca __45-[FlutterMethodChannel setMethodCallHandler:]_block_invoke + 104
	9   Flutter                             0x00000001064e51fa _ZNK7flutter21PlatformMessageRouter21HandlePlatformMessageEN3fml6RefPtrINS_15PlatformMessageEEE + 166
	10  Flutter                             0x00000001064ea40a _ZN7flutter15PlatformViewIOS21HandlePlatformMessageEN3fml6RefPtrINS_15PlatformMessageEEE + 38
	11  Flutter                             0x0000000106877ab9 _ZNSt3__110__function6__funcIZN7flutter5Shell29OnEngineHandlePlatformMessageEN3fml6RefPtrINS2_15PlatformMessageEEEE4$_36NS_9allocatorIS8_EEFvvEEclEv + 83
	12  Flutter                             0x00000001067fb69a _ZN3fml15MessageLoopImpl10FlushTasksENS_9FlushTypeE + 160
	13  Flutter                             0x00000001068000e6 _ZN3fml17MessageLoopDarwin11OnTimerFireEP16__CFRunLoopTimerPS0_ + 26
	14  CoreFoundation                      0x00007fff20390c57 __CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__ + 20
	15  CoreFoundation                      0x00007fff2039072a __CFRunLoopDoTimer + 926
	16  CoreFoundation                      0x00007fff2038fcdd __CFRunLoopDoTimers + 265
	17  CoreFoundation                      0x00007fff2038a35e __CFRunLoopRun + 1949
	18  CoreFoundation                      0x00007fff203896d6 CFRunLoopRunSpecific + 567
	19  GraphicsServices                    0x00007fff2c257db3 GSEventRunModal + 139
	20  UIKitCore                           0x00007fff24696cf7 -[UIApplication _run] + 912
	21  UIKitCore                           0x00007fff2469bba8 UIApplicationMain + 101
	22  Runner                              0x0000000105511c3b main + 75
	23  libdyld.dylib                       0x00007fff2025a3e9 start + 1
```