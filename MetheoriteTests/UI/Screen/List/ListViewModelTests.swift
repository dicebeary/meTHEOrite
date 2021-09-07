//
//  ListViewModelTests.swift
//  FortnightlyTests
//
//  Created by Vajda Kristóf on 2021. 07. 18..
//

import XCTest
import Nimble
import RxBlocking
import RxSwift
import RxCocoa
import SwiftyMocky
import Resolver
@testable import Domain
@testable import Theo

class ListViewModelTests: XCTestCase {
    var interactor: MeteoriteLandingInteractorInterfaceMock!
    var sut: ListViewModel!

    override func setUp() {
        super.setUp()
        interactor = MeteoriteLandingInteractorInterfaceMock()
        Resolver.register { self.interactor }
            .implements(MeteoriteLandingInteractorInterface.self)
        sut = ListViewModel()
    }

    override func tearDown() {
        interactor = nil
        sut = nil
        super.tearDown()
    }
}

extension ListViewModelTests {
    func testIdleScreenWithoutFavourites() throws {
        // Arrange
        Given(interactor, .landings(getter: .just(mockLandings)))
        Given(interactor, .favourites(getter: .just([])))

        let itemSelected = ControlEvent<IndexPath>(events: Observable<IndexPath>.never())
        let favouriteSelected = ControlEvent<FavouriteToggle>(events: Observable<FavouriteToggle>.never())
        let screenEvents = ListViewController.Events(itemSelected: itemSelected, favouriteSelected: favouriteSelected)
        let input = ListViewModel.Input(screenEvents: screenEvents)
        
        // Act
        let output = sut.map(from: input)
        
        // Assert
        Verify(interactor, .landings)
        Verify(interactor, .favourites)

        let items = try output.screenData.items.toBlocking(timeout: 1.0).first()
        
        expect(items?.count).to(equal(3))
        
        expect(items?[0].id).to(equal("123455"))
        expect(items?[0].isFavourite).to(beFalse())
        
        expect(items?[1].id).to(equal("123456"))
        expect(items?[1].isFavourite).to(beFalse())
        
        expect(items?[2].id).to(equal("123457"))
        expect(items?[2].isFavourite).to(beFalse())
    }

    func testIdleScreenWithFavourites() throws {
        // Arrange
        let givenFavourites = [mockLandings[0].id, mockLandings[2].id]
        Given(interactor, .landings(getter: .just(mockLandings)))
        Given(interactor, .favourites(getter: .just(givenFavourites)))

        let itemSelected = ControlEvent<IndexPath>(events: Observable<IndexPath>.never())
        let favouriteSelected = ControlEvent<FavouriteToggle>(events: Observable<FavouriteToggle>.never())
        let screenEvents = ListViewController.Events(itemSelected: itemSelected, favouriteSelected: favouriteSelected)
        let input = ListViewModel.Input(screenEvents: screenEvents)
        
        // Act
        let output = sut.map(from: input)
        
        // Assert
        Verify(interactor, .landings)
        Verify(interactor, .favourites)

        let items = try output.screenData.items.toBlocking(timeout: 1.0).first()
        
        expect(items?.count).to(equal(3))
        
        expect(items?[0].id).to(equal("123455"))
        expect(items?[0].isFavourite).to(beTrue())
        
        expect(items?[1].id).to(equal("123456"))
        expect(items?[1].isFavourite).to(beFalse())
        
        expect(items?[2].id).to(equal("123457"))
        expect(items?[2].isFavourite).to(beTrue())
    }

    func testSaveFavourite() throws {
        // Arrange
        Given(interactor, .landings(getter: .just(mockLandings)))
        Given(interactor, .favourites(getter: .just([])))
        Given(interactor, .saveFavourite(id: .any, willReturn: .empty()))

        let favouriteToggle: FavouriteToggle = (mockLandings[0].id, false)
        
        let itemSelected = ControlEvent<IndexPath>(events: Observable<IndexPath>.never())
        let favouriteSelected = ControlEvent<FavouriteToggle>(events: Observable<FavouriteToggle>.just(favouriteToggle))
        let screenEvents = ListViewController.Events(itemSelected: itemSelected, favouriteSelected: favouriteSelected)
        let input = ListViewModel.Input(screenEvents: screenEvents)
        
        // Act
        let _ = sut.map(from: input)
        
        // Assert
        Verify(interactor, .landings)
        Verify(interactor, .favourites)
        Verify(interactor, .saveFavourite(id: .value(mockLandings[0].id)))
    }

    func testRemoveFavourite() throws {
        // Arrange
        Given(interactor, .landings(getter: .just(mockLandings)))
        Given(interactor, .favourites(getter: .just([])))
        Given(interactor, .removeFavourite(id: .any, willReturn: .empty()))

        let favouriteToggle: FavouriteToggle = (mockLandings[0].id, true)
        
        let itemSelected = ControlEvent<IndexPath>(events: Observable<IndexPath>.never())
        let favouriteSelected = ControlEvent<FavouriteToggle>(events: Observable<FavouriteToggle>.just(favouriteToggle))
        let screenEvents = ListViewController.Events(itemSelected: itemSelected, favouriteSelected: favouriteSelected)
        let input = ListViewModel.Input(screenEvents: screenEvents)
        
        // Act
        let _ = sut.map(from: input)
        
        // Assert
        Verify(interactor, .landings)
        Verify(interactor, .favourites)
        Verify(interactor, .removeFavourite(id: .value(mockLandings[0].id)))
    }
}

private extension ListViewModelTests {
    var mockLandings: [MeteoriteLanding] {
        [
            MeteoriteLanding(name: "teszt1",
                             id: "123455",
                             meteoriteClass: "C1",
                             mass: 1000,
                             fall: .fell,
                             year: Date(),
                             location: GeoLocation(longitude: 20.2020, latitude: 40.4040)),
            MeteoriteLanding(name: "teszt2",
                             id: "123456",
                             meteoriteClass: "C1",
                             mass: 10,
                             fall: .found,
                             year: Date(),
                             location: GeoLocation(longitude: 20.2021, latitude: 40.4041)),
            MeteoriteLanding(name: "teszt3",
                             id: "123457",
                             meteoriteClass: "C1",
                             mass: 100,
                             fall: .fell,
                             year: Date(),
                             location: GeoLocation(longitude: 20.2022, latitude: 40.4042)),
        ]
    }
}

