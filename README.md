![punchcard logo](https://cloud.githubusercontent.com/assets/879038/21446438/06168ac8-c894-11e6-87e3-8ad1e5498589.png)

![Swift3](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat")
[![Platform](https://img.shields.io/cocoapods/p/Punchcard.svg?style=flat)](http://cocoapods.org/pods/Punchcard)
[![Version](https://img.shields.io/cocoapods/v/Punchcard.svg?style=flat)](http://cocoapods.org/pods/Punchcard)
[![License](https://img.shields.io/cocoapods/l/Punchcard.svg?style=flat)](http://cocoapods.org/pods/Punchcard)

Description
--------------

`Punchcard` is a customizable punchcard view written in Swift that can be used to display a measure of progression through a series of actions.

![Example](https://cloud.githubusercontent.com/assets/879038/21446576/d06ec366-c895-11e6-8535-b4d01313a0b3.png)

In this screenshot the user has achieved 2 out of 5 punches, and the images used are the [StockX](https://stockx.com) logo.

# Contents
1. [Features](#features)
3. [Installation](#installation)
4. [Supported OS & SDK versions](#supported-versions)
5. [Usage](#usage)
6. [License](#license)
7. [Contact](#contact)

##<a name="features"> Features </a>

- [x] Supports AutoLayout.
- [x] Applies a random transform (translation and rotation) to the punches to simulate a real-life stamp.
- [x] Supports any number of punches as long as they fit within the bounds of the view.
- [x] Supports customizing background images of all punches.
- [x] Supports being created either in code or a Storyboard.

<a name="installation"> Installation </a>
--------------

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate `Punchcard` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'Punchcard'
```

Then, run the following command:

```bash
$ pod install
```

In case Xcode complains (<i>"Cannot load underlying module for Punchcard"</i>) go to Product and choose Clean (or simply press <kbd>⇧</kbd><kbd>⌘</kbd><kbd>K</kbd>).

### Manually

If you prefer not to use CocoaPods, you can integrate `Punchcard` into your project manually.

<a name="supported-versions"> Supported OS & SDK Versions </a>
-----------------------------

* Supported build target - iOS 8.2+ (Xcode 7.3+)

<a name="usage"> Usage </a>
--------------

`Punchcard` is state based. To configure the view, simply update the state value with whatever values you'd like, and re-set the state:

1) First you should set up the `Punchcard`:

```swift
var punchcardView = PunchcardView()

var state = punchcardView.state
state.backgroundColor = UIColor(patternImage: UIImage(named: "Punchcard-Background-Pattern")!)
state.borderColor = .lightGray
state.emptyPunchImage = UIImage(named: "X-Stamp-Empty")
state.filledPunchImage = UIImage(named: "X-Stamp-Fill")
state.punchesRequired = 5
state.punchNumberColor = .black
state.punchNumberFont = .systemFont(ofSize: 14)
state.rewardTextFont = .systemFont(ofSize: 11)
state.rewardText = "FREE SHIPPING"
state.rewardTextColor = .gray
state.rewardFillColor = .green
        
punchcardView.state = state
```

2) In order to set the punches received, modify the `state` object:

```swift

var state = punchcardView.state
state.punchesReceived = 2
punchcardView.state = state
```

<a name="license"> License </a>
--------------

`BubbleRankingIndicator` is developed by [Josh Sklar](https://www.linkedin.com/in/jrmsklar) at [StockX](https://stockx.com) and is released under the MIT license. See the `LICENSE` file for details.

<a name="contact"> Contact </a>
--------------

You can follow or drop me a line on [my Twitter account](https://twitter.com/jrmsklar). If you find any issues on the project, you can open a ticket. Pull requests are also welcome.
