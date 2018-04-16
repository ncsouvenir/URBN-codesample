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

## Four Square Code Challenge Requirments
1. Your app should be at least largely written in Swift if not 100% Swift.
- testing indentation
2. Networking code. Your app should NOT use one of the available Foursquare sdk's so either raw NSURLSessions/Requests or something like AFNetworking/AlamoFire
3. Geolocation of user should also handle when geolocation is off or not enabled yet
4. A way to select geolocation as an option (a button maybe)
5. Search by query should allow users to search based on a query rather than their current location
6. A list of results from foursquare with all the information you believe a user needs to see
An icon & distance would be nice
7. A detail view for a venue with extended details that you think are important (like venue photo, etc)
 

For extra credit you could:

Add in some nice transitions to and from list views to details
Add your own personal UI flare
Make the list view infinitely scrollable (pagination)


## Technologies Used
- MapKit
- Core Location
- User Defaults


## App Flow
**Location On**| **Location Off** |
:---: | :---: | 
![gif](https://github.com/ncsouvenir/URBN-codesample/blob/master/Gifs/searchwithlocation.gif) <br/>Search for venue and see reults in mapview| ![gif](https://github.com/ncsouvenir/URBN-codesample/blob/master/Gifs/nolocationsearch.gif) <br/> Searching with NO location | 
**Vanue Info**| **List View** |
![gif](https://github.com/ncsouvenir/URBN-codesample/blob/master/Gifs/choosevenueseeinfo.gif) <br/>Choose a venue to see additional information | ![gif](https://github.com/ncsouvenir/URBN-codesample/blob/master/Gifs/showinglistview.gif) <br/>See venue results in a list view as well|

