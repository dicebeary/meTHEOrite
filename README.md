# Fortnightly

The Fortnightly is a small app but it is totally prepared to be a scalable large application. The app has been sliced into modules and different modules represents the several parts of MVVM (+Interactor) architecture.
The MVVM is quite accurate to cover all the use cases in this application but the Interactor layer needed to be created for the further demands where data should be passed between screens and conserved app-wide states.

## Structure of the app

The app has three modules:
* Core
* Domain
* Fortnightly (the main module)

## Core

The Core represents the layer where the app stores the data. It implements the network layer and the interactor layer as well. The main purpose of separating them was to make a cleaner UI layer where the ViewModel and the UI do not need to know where the data comes from.
The Core uses **Moya+RxSwift** for high-level reactive network communication.


## Domain

Domain is the contract between the main module and the Core. The Domain defines all the objects that will be used during UI representation. The main purpose of separating them to detach all the network-like dependencies (e.g. network models, mappers) - there is no need to be seen at the main module. The Domain also serves as the collection of app-wide used protocols and objects. They represent the data - irrespectively of usage place.

## Other app-related information

### Schemes

It has two schemes:
* Fortnightly
* Fortnightly (Mock)

The latter one supports to develop in the lack of internet connectivity (or not to deplete the API limitation :P).

### Dependency Injection

For passing instances and references the app uses Swinject to store all of them in its default container. Most of the instances has scope of instantiating during every call. Only the Core components has Singleton-like scope.

### Mock strategy

For mocking layers of the app it uses SwiftyMocky. It speeds up the process of testing without dependencies and it helps to mock different states.

### View contracts

The main module uses ViewDataBinder and ViewEventListener which aim to make a strict channel between the UI and the ViewModel. ViewDataBinder is responsible for creating the View representation object, meanwhile the ViewEventListener is for "catching" the events of the views (e.g. tapping on layouts, swiping etc.).

### Further possibilities to cultivate

#### Navigation

The app currently does not have any global and stable Navigation framework. It has a light-weight tool to extract navigation from ViewController.

#### Crash analytics

By the time a Firebase-Crashlytics integration would be pleased just to show any crash report. Furthermore if a business demand comes more Analytical tool should be considered.

#### Storyboard -> Xib-based / Code-base

The ViewControllers are "drawn" on the Main.storyboard's canvas. It has several limitations but taking into consideration of the app size, it was sufficient. For scaling further the ViewController's should be separated from storyboard.