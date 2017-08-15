# AnyControllerDialog

[![CI Status](http://img.shields.io/travis/npu3pak/AnyControllerDialog.svg?style=flat)](https://travis-ci.org/npu3pak/AnyControllerDialog)
[![Version](https://img.shields.io/cocoapods/v/AnyControllerDialog.svg?style=flat)](http://cocoapods.org/pods/AnyControllerDialog)
[![License](https://img.shields.io/cocoapods/l/AnyControllerDialog.svg?style=flat)](http://cocoapods.org/pods/AnyControllerDialog)
[![Platform](https://img.shields.io/cocoapods/p/AnyControllerDialog.svg?style=flat)](http://cocoapods.org/pods/AnyControllerDialog)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![Alt Text](https://media.giphy.com/media/l1J3o2RO1nKi7RRM4/giphy.gif)

## Requirements

Swift 3, iOS 8+

## Installation

AnyControllerDialog is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AnyControllerDialog", :git => 'https://github.com/npu3pak/ios-lib-any-controller-dialog.git' 
```

## Usage

1. Import library
```swift
import AnyControllerDialog
```
2. Instantiate view controller that you want to display as dialog:
```swift
let dialogContentController = storyboard?.instantiateViewController(withIdentifier: "DialogContent")
```
3. Show controller as dialog:
```swift
showDialog(dialogContentController!, height: 200, width: 200, top: 70, completion: {print("Presented!")})
```
4. Dismiss controller properly:
```swift
dismissDialog(dialogContentController, completion: {print("Dismissed!")})
```

## Author

Евгений Сафронов, evsafronov.personal@yandex.ru

## License

AnyControllerDialog is available under the MIT license. See the LICENSE file for more info.
