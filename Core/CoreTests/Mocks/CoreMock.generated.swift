// Generated using Sourcery 1.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 4.0.4

import SwiftyMocky
import XCTest
import Domain
import Foundation
import RxCocoa
import RxSwift
@testable import Core


// MARK: - NewsInteractorInterface

open class NewsInteractorInterfaceMock: NewsInteractorInterface, Mock {
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





    open func getNews() -> Observable<[Article]> {
        addInvocation(.m_getNews)
		let perform = methodPerformValue(.m_getNews) as? () -> Void
		perform?()
		var __value: Observable<[Article]>
		do {
		    __value = try methodReturnValue(.m_getNews).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getNews(). Use given")
			Failure("Stub return value not specified for getNews(). Use given")
		}
		return __value
    }

    open func getSelectedArticle() -> Observable<Article> {
        addInvocation(.m_getSelectedArticle)
		let perform = methodPerformValue(.m_getSelectedArticle) as? () -> Void
		perform?()
		var __value: Observable<Article>
		do {
		    __value = try methodReturnValue(.m_getSelectedArticle).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getSelectedArticle(). Use given")
			Failure("Stub return value not specified for getSelectedArticle(). Use given")
		}
		return __value
    }

    open func fetchNews(text: String?) -> Completable {
        addInvocation(.m_fetchNews__text_text(Parameter<String?>.value(`text`)))
		let perform = methodPerformValue(.m_fetchNews__text_text(Parameter<String?>.value(`text`))) as? (String?) -> Void
		perform?(`text`)
		var __value: Completable
		do {
		    __value = try methodReturnValue(.m_fetchNews__text_text(Parameter<String?>.value(`text`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fetchNews(text: String?). Use given")
			Failure("Stub return value not specified for fetchNews(text: String?). Use given")
		}
		return __value
    }

    open func fetchSources() -> Completable {
        addInvocation(.m_fetchSources)
		let perform = methodPerformValue(.m_fetchSources) as? () -> Void
		perform?()
		var __value: Completable
		do {
		    __value = try methodReturnValue(.m_fetchSources).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fetchSources(). Use given")
			Failure("Stub return value not specified for fetchSources(). Use given")
		}
		return __value
    }

    open func selectArticle(_ item: Article) -> Completable {
        addInvocation(.m_selectArticle__item(Parameter<Article>.value(`item`)))
		let perform = methodPerformValue(.m_selectArticle__item(Parameter<Article>.value(`item`))) as? (Article) -> Void
		perform?(`item`)
		var __value: Completable
		do {
		    __value = try methodReturnValue(.m_selectArticle__item(Parameter<Article>.value(`item`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for selectArticle(_ item: Article). Use given")
			Failure("Stub return value not specified for selectArticle(_ item: Article). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getNews
        case m_getSelectedArticle
        case m_fetchNews__text_text(Parameter<String?>)
        case m_fetchSources
        case m_selectArticle__item(Parameter<Article>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getNews, .m_getNews): return .match

            case (.m_getSelectedArticle, .m_getSelectedArticle): return .match

            case (.m_fetchNews__text_text(let lhsText), .m_fetchNews__text_text(let rhsText)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsText, rhs: rhsText, with: matcher), lhsText, rhsText, "text"))
				return Matcher.ComparisonResult(results)

            case (.m_fetchSources, .m_fetchSources): return .match

            case (.m_selectArticle__item(let lhsItem), .m_selectArticle__item(let rhsItem)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsItem, rhs: rhsItem, with: matcher), lhsItem, rhsItem, "_ item"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getNews: return 0
            case .m_getSelectedArticle: return 0
            case let .m_fetchNews__text_text(p0): return p0.intValue
            case .m_fetchSources: return 0
            case let .m_selectArticle__item(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getNews: return ".getNews()"
            case .m_getSelectedArticle: return ".getSelectedArticle()"
            case .m_fetchNews__text_text: return ".fetchNews(text:)"
            case .m_fetchSources: return ".fetchSources()"
            case .m_selectArticle__item: return ".selectArticle(_:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getNews(willReturn: Observable<[Article]>...) -> MethodStub {
            return Given(method: .m_getNews, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getSelectedArticle(willReturn: Observable<Article>...) -> MethodStub {
            return Given(method: .m_getSelectedArticle, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchNews(text: Parameter<String?>, willReturn: Completable...) -> MethodStub {
            return Given(method: .m_fetchNews__text_text(`text`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchSources(willReturn: Completable...) -> MethodStub {
            return Given(method: .m_fetchSources, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func selectArticle(_ item: Parameter<Article>, willReturn: Completable...) -> MethodStub {
            return Given(method: .m_selectArticle__item(`item`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getNews(willProduce: (Stubber<Observable<[Article]>>) -> Void) -> MethodStub {
            let willReturn: [Observable<[Article]>] = []
			let given: Given = { return Given(method: .m_getNews, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Observable<[Article]>).self)
			willProduce(stubber)
			return given
        }
        public static func getSelectedArticle(willProduce: (Stubber<Observable<Article>>) -> Void) -> MethodStub {
            let willReturn: [Observable<Article>] = []
			let given: Given = { return Given(method: .m_getSelectedArticle, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Observable<Article>).self)
			willProduce(stubber)
			return given
        }
        public static func fetchNews(text: Parameter<String?>, willProduce: (Stubber<Completable>) -> Void) -> MethodStub {
            let willReturn: [Completable] = []
			let given: Given = { return Given(method: .m_fetchNews__text_text(`text`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Completable).self)
			willProduce(stubber)
			return given
        }
        public static func fetchSources(willProduce: (Stubber<Completable>) -> Void) -> MethodStub {
            let willReturn: [Completable] = []
			let given: Given = { return Given(method: .m_fetchSources, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Completable).self)
			willProduce(stubber)
			return given
        }
        public static func selectArticle(_ item: Parameter<Article>, willProduce: (Stubber<Completable>) -> Void) -> MethodStub {
            let willReturn: [Completable] = []
			let given: Given = { return Given(method: .m_selectArticle__item(`item`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Completable).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getNews() -> Verify { return Verify(method: .m_getNews)}
        public static func getSelectedArticle() -> Verify { return Verify(method: .m_getSelectedArticle)}
        public static func fetchNews(text: Parameter<String?>) -> Verify { return Verify(method: .m_fetchNews__text_text(`text`))}
        public static func fetchSources() -> Verify { return Verify(method: .m_fetchSources)}
        public static func selectArticle(_ item: Parameter<Article>) -> Verify { return Verify(method: .m_selectArticle__item(`item`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getNews(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getNews, performs: perform)
        }
        public static func getSelectedArticle(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getSelectedArticle, performs: perform)
        }
        public static func fetchNews(text: Parameter<String?>, perform: @escaping (String?) -> Void) -> Perform {
            return Perform(method: .m_fetchNews__text_text(`text`), performs: perform)
        }
        public static func fetchSources(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_fetchSources, performs: perform)
        }
        public static func selectArticle(_ item: Parameter<Article>, perform: @escaping (Article) -> Void) -> Perform {
            return Perform(method: .m_selectArticle__item(`item`), performs: perform)
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

// MARK: - NewsServiceInterface

open class NewsServiceInterfaceMock: NewsServiceInterface, Mock {
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





    open func getNewsList(text: String?) -> Single<NewsApiModel> {
        addInvocation(.m_getNewsList__text_text(Parameter<String?>.value(`text`)))
		let perform = methodPerformValue(.m_getNewsList__text_text(Parameter<String?>.value(`text`))) as? (String?) -> Void
		perform?(`text`)
		var __value: Single<NewsApiModel>
		do {
		    __value = try methodReturnValue(.m_getNewsList__text_text(Parameter<String?>.value(`text`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getNewsList(text: String?). Use given")
			Failure("Stub return value not specified for getNewsList(text: String?). Use given")
		}
		return __value
    }

    open func getSources() -> Single<SourcesApiModel> {
        addInvocation(.m_getSources)
		let perform = methodPerformValue(.m_getSources) as? () -> Void
		perform?()
		var __value: Single<SourcesApiModel>
		do {
		    __value = try methodReturnValue(.m_getSources).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getSources(). Use given")
			Failure("Stub return value not specified for getSources(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getNewsList__text_text(Parameter<String?>)
        case m_getSources

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getNewsList__text_text(let lhsText), .m_getNewsList__text_text(let rhsText)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsText, rhs: rhsText, with: matcher), lhsText, rhsText, "text"))
				return Matcher.ComparisonResult(results)

            case (.m_getSources, .m_getSources): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getNewsList__text_text(p0): return p0.intValue
            case .m_getSources: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getNewsList__text_text: return ".getNewsList(text:)"
            case .m_getSources: return ".getSources()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getNewsList(text: Parameter<String?>, willReturn: Single<NewsApiModel>...) -> MethodStub {
            return Given(method: .m_getNewsList__text_text(`text`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getSources(willReturn: Single<SourcesApiModel>...) -> MethodStub {
            return Given(method: .m_getSources, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getNewsList(text: Parameter<String?>, willProduce: (Stubber<Single<NewsApiModel>>) -> Void) -> MethodStub {
            let willReturn: [Single<NewsApiModel>] = []
			let given: Given = { return Given(method: .m_getNewsList__text_text(`text`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<NewsApiModel>).self)
			willProduce(stubber)
			return given
        }
        public static func getSources(willProduce: (Stubber<Single<SourcesApiModel>>) -> Void) -> MethodStub {
            let willReturn: [Single<SourcesApiModel>] = []
			let given: Given = { return Given(method: .m_getSources, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<SourcesApiModel>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getNewsList(text: Parameter<String?>) -> Verify { return Verify(method: .m_getNewsList__text_text(`text`))}
        public static func getSources() -> Verify { return Verify(method: .m_getSources)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getNewsList(text: Parameter<String?>, perform: @escaping (String?) -> Void) -> Perform {
            return Perform(method: .m_getNewsList__text_text(`text`), performs: perform)
        }
        public static func getSources(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getSources, performs: perform)
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

