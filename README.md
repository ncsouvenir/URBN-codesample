![Banner](https://github.com/ncsouvenir/URBN-codesample/blob/master/Gifs/Screen%20Shot%202018-04-16%20at%205.11.34%20PM.png)


## <p align="center"> Find A Venue allows users to search for desired venues and get directions as well as additional information
</p>

# Getting Started

## Requirements
- iOS 11.0+ / Mac OS X 10.11+ / tvOS 9.0+
- Xcode 9.0+
- Swift 4.0+

### CocoaPods Installation
CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

`$ sudo gem install cocoapods`

### Pods
- [KingFisher](https://cocoapods.org/pods/Kingfisher)
- [SnapKit](http://snapkit.io/docs)
- [Alamofire](https://cocoapods.org/pods/Alamofire)

### How to Install Pods
To integrate these pods into your Xcode project using CocoaPods, specify it in your Podfile:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SnapKit'
    pod 'AlamoFire'
    pod 'KingFisher'
end
```
Then, run the following command in Terminal:

`$ pod install`


## Technologies Used
- MapKit
- Core Location
- User Defaults


## App Flow
**Login View**| **Profile View** |
:---: | :---: |
![gif](https://github.com/melissahe/TestInk/blob/qa/Gifs/Login.gif) <br/>Search for venue and see reults in mapview| ![gif](https://github.com/melissahe/TestInk/blob/qa/Gifs/Like%20and%20Fev.gif) <br/>Choose a venue to see additonal information | 
**Cropping**| **Filtering** |
![gif](https://github.com/melissahe/TestInk/blob/qa/Gifs/CropDemo.gif) <br/>Users can see the same venue results in a listview | ![gif](https://github.com/melissahe/TestInk/blob/qa/Gifs/FilterDemo.gif) <br/>Add filters to photos upload from photo library| |

