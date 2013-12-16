# EEEInterventions

<!-- 
[![Version](http://cocoapod-badges.herokuapp.com/v/EEEInterventions/badge.png)](http://cocoadocs.org/docsets/EEEInterventions)
[![Platform](http://cocoapod-badges.herokuapp.com/p/EEEInterventions/badge.png)](http://cocoadocs.org/docsets/EEEInterventions)
-->

## Classes

### EEEMethodInvocationSplitter (MIS)

Instantiate by providing two other object instances to the splitter, one called the 'intermediary' object and another the 'target' object. Any method called on the splitter will be forwarded to the intermediary object if it implements the method, otherwise it will be forwarded to the target object. You could use this for example to add your own `UITableViewDelegate`-conforming class to an existing UITableViewController setup, to add extra delegation features to the setup without cluttering up (or intervening with) the view controller's methods.

### EEECyclicDelegateRetainer (CDR)

In the classic delegate pattern, delegate objects are assigned as weak properties of other objects. This means your application needs to hold on to the delegate object somewhere else, to prevent it from being deallocated prematurely, preventing bad access exceptions. There are scenarios however, where you don't want to be bothered with storing the delegate and it will only clutter your app's code. It's these scenarios that the cyclic delegate retainer was created for. Consider the scenario of a `UIAlertView` delegate. The alert view shows your message and sends messages about which button was clicked to its delegate. If in the delegate methods you execute some arbitrary code that doesn't rely on any other code from your view controller, you can set up a CDR with a separate delegate object. The delegate is retained by the CDR until the alert view button press is detected and handled, after which you call `breakRetainCycle` on the CDR, which cleans up both the CDR and your delegate object from memory.

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

