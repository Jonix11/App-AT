# App-AT

App-AT is an iOS app that use marvel api to show characters and events. You can tap in each one of it to see little more information.

Also have a little form which realize a post request to Httpbin api and an image picker using PHPhotoLibrary.

It uses VIPER architectural pattern and Alamofire, SDWebImage, PromiseKit, ObjectMapper and SnapKit pods.

## Installation

First of all, you have to **rename NetworkInfo_Rename.plist file to NetworkInfo.plist inside Provider/Network folder** and then introduce your own api key, hash and timestamp to be able to connect to Marvel API.

This app use **CocoaPods**, to run it, you must to execute the following command from the terminal to install CocoaPods dependencies:

`pod install`
