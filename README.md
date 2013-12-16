# EEEInterventions

<!-- 
[![Version](http://cocoapod-badges.herokuapp.com/v/EEEInterventions/badge.png)](http://cocoadocs.org/docsets/EEEInterventions)
[![Platform](http://cocoapod-badges.herokuapp.com/p/EEEInterventions/badge.png)](http://cocoadocs.org/docsets/EEEInterventions)
-->

## Classes

### EEEMethodInvocationSplitter

Instantiate by providing two other object instances to the splitter, one called the 'intermediary' object and another the 'target' object. Any method called on the splitter will be forwarded to the intermediary object if it implements the method, otherwise it will be forwarded to the target object. You could use this for example to add your own `UITableViewDelegate`-conforming class to an existing UITableViewController setup, to add extra delegation features to the setup without cluttering up (or intervening with) the view controller's methods.

## Usage

To test the example library project; clone the repo, and run `pod install` from the Project directory first.

## Installation

EEEInterventions is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "EEEInterventions"

## Author

Eric-Paul Lecluse, e@epologee.com

## License

EEEInterventions is available under the MIT license. See the LICENSE file for more info.

