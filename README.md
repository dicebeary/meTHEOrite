# meTHEOrite

The meTHEOrite is a small app but it is totally prepared to be a scalable large application. The app has been sliced into modules and different modules represents the several parts of MVVM (+Interactor) architecture.
The MVVM is quite accurate to cover all the use cases in this application but the Interactor layer needed to be created for the further demands where data should be passed between screens and conserved app-wide states.

## Setup

* Clone repository
* Hit `pod install`
* Run `Metheorite.xcworkspace`
* (Optional) Select mock scheme if you don't want to use network communication
* Build & Run

## Structure of the app

The app has three modules:
* Core
* Domain
* Metheorite (the main module)

## Core

The Core represents the layer where the app stores the data. It implements the management of network, location and the interactor layer as well. The main purpose of separating them was to make a cleaner UI layer where the ViewModel and the UI do not need to know where the data comes from.
The Core uses **Moya+RxSwift** for high-level reactive network communication.


## Domain

Domain is the contract between the main module and the Core. The Domain defines all the objects that will be used during UI representation. The main purpose of separating them to detach all the network-like dependencies (e.g. network models, mappers) - there is no need to be seen at the main module. The Domain also serves as the collection of app-wide used protocols and objects. They represent the data - irrespectively of usage place.

## Other app-related information

### Schemes

It has two schemes:
* meTHEOrite
* meTHEOrite (Mock)

The latter one supports developing during lack of internet connectivity.

### Dependency Injection

For passing instances and references the app uses `Resolver` to store all of them in its default container. Most of the instances has scope of `.graph` during every call. Only the Core components has Singleton-like `.application` scope.

### Mock strategy

Regarding tests the app uses `SwiftyMocky` for mocking layers. It speeds up the process of testing without dependencies and it helps to mock different states.

### View contracts

The main module uses ViewDataBinder and ViewEventListener which aim to make a strict channel between the UI and the ViewModel. ViewDataBinder is responsible for creating the View representation object, meanwhile the ViewEventListener is for "catching" the events of a given view (e.g. tapping on layouts, swiping etc.).

### Further possibilities to improve

#### Navigation

The app uses a light-weight Coordinator pattern. The concept works but it can be improved.

#### Crash analytics

By the time a Firebase-Crashlytics integration would be pleased just to show any crash report. Furthermore if a business demand comes more Analytical tool should be considered.
