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

## Four Square Code Challenge Requirements
1. **Your app should be at least largely written in Swift if not 100% Swift.**
    - The code is written in 100% swift code
2. **Networking code. Your app should NOT use one of the available Foursquare sdk's so either raw NSURLSessions/Requests or something like AFNetworking/AlamoFire**
    - I used Alamofire for as he network helper for the app
3. **Geolocation of user should also handle when geolocation is off or not enabled yet**
    - The user is able to search for venues whether their location is on or off. However, if there's problems with networking,       the app notifies the user of that as well
4. **A way to select geolocation as an option (a button maybe)**
    - There is a location button that a user can use to either turn their location on or off in their phone settings
5. **Search by query should allow users to search based on a query rather than their current location**
    - The user is able to search for any venue in whatever location they desire within the United States
6. **A list of results from foursquare with all the information you believe a user needs to see**
    - If the map view is not clear enough, there is a list view of venue results, including venue icon, venue name, category        of venue and distance, that the user can also look through
7. **A detail view for a venue with extended details that you think are important (like venue photo, etc)**
    - The user can click on a venue in either the map view or list results view to see addtional information about the venue            and get directions as well.

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

