# MessengerBubbles
![Banner](Screenshots/Banner.png?)

[![Version](https://img.shields.io/cocoapods/v/MessengerBubbles.svg?style=flat)](https://cocoapods.org/pods/MessengerBubbles)
[![License](https://img.shields.io/cocoapods/l/MessengerBubbles.svg?style=flat)](https://cocoapods.org/pods/MessengerBubbles)
[![Platform](https://img.shields.io/cocoapods/p/MessengerBubbles.svg?style=flat)](https://cocoapods.org/pods/MessengerBubbles)

![App Image](Screenshots/gif.gif?)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

### CocoaPods

MessengerBubbles is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```bash
pod 'MessengerBubbles'
```

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate CodableCloudKit into your project manually. Simply drag the `Sources` Folder into your Xcode project.

## Usage

### From Storyboard

MessengerBubbles is a subview of `UIView`

![Storyboard](Screenshots/Storyboard.png?)

Just create a `UIView` and replace the Custom Class with `MessengerBubbles`

You can choose if you want to enable the online bubble indicator, if the user or group is online or not, change the online buble color and border color.

### Programmatically

You have many ways to create a `MessengerBubbles`

```swift
public init(size: CGFloat,
            borderColor: UIColor = .white,
            onlineBubbleColor: UIColor = PrivateConstants.onlineBubbleColor,
            enableOnlineBubble: Bool = true,
            isOnline: Bool = false)


public init(images: [UIImage?]?,
            size: CGFloat,
            borderColor: UIColor = .white,
            onlineBubbleColor: UIColor = PrivateConstants.onlineBubbleColor,
            enableOnlineBubble: Bool = true,
            isOnline: Bool = false)

public init(urls: [String?]?,
            size: CGFloat,
            borderColor: UIColor = .white,
            onlineBubbleColor: UIColor = PrivateConstants.onlineBubbleColor,
            enableOnlineBubble: Bool = true,
            isOnline: Bool = false)
```

Size is always requiered. All others properties have a default value.

```swift
MessengerBubbles(size: 60) // With size only

MessengerBubbles(size: 60, borderColor: .blue, 
                 onlineBubbleColor: .yellow,
                 enabledOnlineBubble: false,
                 isOnline: false) // With custom values

MessengerBubbles(images: images,
                 size: 60) // With an array of UIImage at initialization

MessengerBubbles(urls: urls,
                 size: 60) // With an array of String at initialization
```

You can set images after `MessengerBubbles` has been created.
If your array contains 1 element, it will create a single bubble.
By the way, if it contains 2 elements or more, it will create 2 bubbles even if it contains more than 2 elements.

```swift
public func setImages(with images: [UIImage?]?) // Set images with an array of UIImage
public func setImages(with urls: [String?]?) // Set images with an array of String

let bubble = MessengerBubbles(size: 60)
bubble.setImages(with: images)
//or
bubble.setImages(with: urls)
```

`isOnline` and `onlineBubbleColor` can be changed after initialization

```swift
bubble.isOnline = true // or false
bubble.onlineBubbleColor = .black // or whatever you want
```

## Author

Laurent Grondin, laurent.grondin@epitech.eu

## Contributing
Contributions are very welcome 🙌

## License

MessengerBubbles is available under the MIT license. See the LICENSE file for more info.
