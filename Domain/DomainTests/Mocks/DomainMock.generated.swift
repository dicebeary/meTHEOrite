// Generated using Sourcery 1.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 4.0.4

import SwiftyMocky
import XCTest
import RxSwift
import RxCocoa
@testable import Domain


// MARK: - MeteoriteLandingInteractorInterface

open class MeteoriteLandingInteractorInterfaceMock: MeteoriteLandingInteractorInterface, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var landings: Observable<[MeteoriteLanding]> {
		get {	invocations.append(.p_landings_get); return __p_landings ?? givenGetterValue(.p_landings_get, "MeteoriteLandingInteractorInterfaceMock - stub value for landings was not defined") }
	}
	private var __p_landings: (Observable<[MeteoriteLanding]>)?

    public var favourites: Observable<[String]> {
		get {	invocations.append(.p_favourites_get); return __p_favourites ?? givenGetterValue(.p_favourites_get, "MeteoriteLandingInteractorInterfaceMock - stub value for favourites was not defined") }
	}
	private var __p_favourites: (Observable<[String]>)?

    public var sortingTypes: Observable<[MeteoriteAttribute]> {
		get {	invocations.append(.p_sortingTypes_get); return __p_sortingTypes ?? givenGetterValue(.p_sortingTypes_get, "MeteoriteLandingInteractorInterfaceMock - stub value for sortingTypes was not defined") }
	}
	private var __p_sortingTypes: (Observable<[MeteoriteAttribute]>)?





    open func fetchLandings() -> Completable {
        addInvocation(.m_fetchLandings)
		let perform = methodPerformValue(.m_fetchLandings) as? () -> Void
		perform?()
		var __value: Completable
		do {
		    __value = try methodReturnValue(.m_fetchLandings).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fetchLandings(). Use given")
			Failure("Stub return value not specified for fetchLandings(). Use given")
		}
		return __value
    }

    open func fetchFavourites() -> Completable {
        addInvocation(.m_fetchFavourites)
		let perform = methodPerformValue(.m_fetchFavourites) as? () -> Void
		perform?()
		var __value: Completable
		do {
		    __value = try methodReturnValue(.m_fetchFavourites).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fetchFavourites(). Use given")
			Failure("Stub return value not specified for fetchFavourites(). Use given")
		}
		return __value
    }

    open func sortMeteorite(by attribute: MeteoriteAttribute) -> Completable {
        addInvocation(.m_sortMeteorite__by_attribute(Parameter<MeteoriteAttribute>.value(`attribute`)))
		let perform = methodPerformValue(.m_sortMeteorite__by_attribute(Parameter<MeteoriteAttribute>.value(`attribute`))) as? (MeteoriteAttribute) -> Void
		perform?(`attribute`)
		var __value: Completable
		do {
		    __value = try methodReturnValue(.m_sortMeteorite__by_attribute(Parameter<MeteoriteAttribute>.value(`attribute`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for sortMeteorite(by attribute: MeteoriteAttribute). Use given")
			Failure("Stub return value not specified for sortMeteorite(by attribute: MeteoriteAttribute). Use given")
		}
		return __value
    }

    open func saveFavourite(id: String) -> Completable {
        addInvocation(.m_saveFavourite__id_id(Parameter<String>.value(`id`)))
		let perform = methodPerformValue(.m_saveFavourite__id_id(Parameter<String>.value(`id`))) as? (String) -> Void
		perform?(`id`)
		var __value: Completable
		do {
		    __value = try methodReturnValue(.m_saveFavourite__id_id(Parameter<String>.value(`id`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for saveFavourite(id: String). Use given")
			Failure("Stub return value not specified for saveFavourite(id: String). Use given")
		}
		return __value
    }

    open func removeFavourite(id: String) -> Completable {
        addInvocation(.m_removeFavourite__id_id(Parameter<String>.value(`id`)))
		let perform = methodPerformValue(.m_removeFavourite__id_id(Parameter<String>.value(`id`))) as? (String) -> Void
		perform?(`id`)
		var __value: Completable
		do {
		    __value = try methodReturnValue(.m_removeFavourite__id_id(Parameter<String>.value(`id`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for removeFavourite(id: String). Use given")
			Failure("Stub return value not specified for removeFavourite(id: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_fetchLandings
        case m_fetchFavourites
        case m_sortMeteorite__by_attribute(Parameter<MeteoriteAttribute>)
        case m_saveFavourite__id_id(Parameter<String>)
        case m_removeFavourite__id_id(Parameter<String>)
        case p_landings_get
        case p_favourites_get
        case p_sortingTypes_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_fetchLandings, .m_fetchLandings): return .match

            case (.m_fetchFavourites, .m_fetchFavourites): return .match

            case (.m_sortMeteorite__by_attribute(let lhsAttribute), .m_sortMeteorite__by_attribute(let rhsAttribute)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAttribute, rhs: rhsAttribute, with: matcher), lhsAttribute, rhsAttribute, "by attribute"))
				return Matcher.ComparisonResult(results)

            case (.m_saveFavourite__id_id(let lhsId), .m_saveFavourite__id_id(let rhsId)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "id"))
				return Matcher.ComparisonResult(results)

            case (.m_removeFavourite__id_id(let lhsId), .m_removeFavourite__id_id(let rhsId)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "id"))
				return Matcher.ComparisonResult(results)
            case (.p_landings_get,.p_landings_get): return Matcher.ComparisonResult.match
            case (.p_favourites_get,.p_favourites_get): return Matcher.ComparisonResult.match
            case (.p_sortingTypes_get,.p_sortingTypes_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_fetchLandings: return 0
            case .m_fetchFavourites: return 0
            case let .m_sortMeteorite__by_attribute(p0): return p0.intValue
            case let .m_saveFavourite__id_id(p0): return p0.intValue
            case let .m_removeFavourite__id_id(p0): return p0.intValue
            case .p_landings_get: return 0
            case .p_favourites_get: return 0
            case .p_sortingTypes_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_fetchLandings: return ".fetchLandings()"
            case .m_fetchFavourites: return ".fetchFavourites()"
            case .m_sortMeteorite__by_attribute: return ".sortMeteorite(by:)"
            case .m_saveFavourite__id_id: return ".saveFavourite(id:)"
            case .m_removeFavourite__id_id: return ".removeFavourite(id:)"
            case .p_landings_get: return "[get] .landings"
            case .p_favourites_get: return "[get] .favourites"
            case .p_sortingTypes_get: return "[get] .sortingTypes"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func landings(getter defaultValue: Observable<[MeteoriteLanding]>...) -> PropertyStub {
            return Given(method: .p_landings_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func favourites(getter defaultValue: Observable<[String]>...) -> PropertyStub {
            return Given(method: .p_favourites_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func sortingTypes(getter defaultValue: Observable<[MeteoriteAttribute]>...) -> PropertyStub {
            return Given(method: .p_sortingTypes_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func fetchLandings(willReturn: Completable...) -> MethodStub {
            return Given(method: .m_fetchLandings, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchFavourites(willReturn: Completable...) -> MethodStub {
            return Given(method: .m_fetchFavourites, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func sortMeteorite(by attribute: Parameter<MeteoriteAttribute>, willReturn: Completable...) -> MethodStub {
            return Given(method: .m_sortMeteorite__by_attribute(`attribute`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func saveFavourite(id: Parameter<String>, willReturn: Completable...) -> MethodStub {
            return Given(method: .m_saveFavourite__id_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func removeFavourite(id: Parameter<String>, willReturn: Completable...) -> MethodStub {
            return Given(method: .m_removeFavourite__id_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchLandings(willProduce: (Stubber<Completable>) -> Void) -> MethodStub {
            let willReturn: [Completable] = []
			let given: Given = { return Given(method: .m_fetchLandings, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Completable).self)
			willProduce(stubber)
			return given
        }
        public static func fetchFavourites(willProduce: (Stubber<Completable>) -> Void) -> MethodStub {
            let willReturn: [Completable] = []
			let given: Given = { return Given(method: .m_fetchFavourites, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Completable).self)
			willProduce(stubber)
			return given
        }
        public static func sortMeteorite(by attribute: Parameter<MeteoriteAttribute>, willProduce: (Stubber<Completable>) -> Void) -> MethodStub {
            let willReturn: [Completable] = []
			let given: Given = { return Given(method: .m_sortMeteorite__by_attribute(`attribute`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Completable).self)
			willProduce(stubber)
			return given
        }
        public static func saveFavourite(id: Parameter<String>, willProduce: (Stubber<Completable>) -> Void) -> MethodStub {
            let willReturn: [Completable] = []
			let given: Given = { return Given(method: .m_saveFavourite__id_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Completable).self)
			willProduce(stubber)
			return given
        }
        public static func removeFavourite(id: Parameter<String>, willProduce: (Stubber<Completable>) -> Void) -> MethodStub {
            let willReturn: [Completable] = []
			let given: Given = { return Given(method: .m_removeFavourite__id_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Completable).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func fetchLandings() -> Verify { return Verify(method: .m_fetchLandings)}
        public static func fetchFavourites() -> Verify { return Verify(method: .m_fetchFavourites)}
        public static func sortMeteorite(by attribute: Parameter<MeteoriteAttribute>) -> Verify { return Verify(method: .m_sortMeteorite__by_attribute(`attribute`))}
        public static func saveFavourite(id: Parameter<String>) -> Verify { return Verify(method: .m_saveFavourite__id_id(`id`))}
        public static func removeFavourite(id: Parameter<String>) -> Verify { return Verify(method: .m_removeFavourite__id_id(`id`))}
        public static var landings: Verify { return Verify(method: .p_landings_get) }
        public static var favourites: Verify { return Verify(method: .p_favourites_get) }
        public static var sortingTypes: Verify { return Verify(method: .p_sortingTypes_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func fetchLandings(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_fetchLandings, performs: perform)
        }
        public static func fetchFavourites(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_fetchFavourites, performs: perform)
        }
        public static func sortMeteorite(by attribute: Parameter<MeteoriteAttribute>, perform: @escaping (MeteoriteAttribute) -> Void) -> Perform {
            return Perform(method: .m_sortMeteorite__by_attribute(`attribute`), performs: perform)
        }
        public static func saveFavourite(id: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_saveFavourite__id_id(`id`), performs: perform)
        }
        public static func removeFavourite(id: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_removeFavourite__id_id(`id`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

