//
//  MainViewModel.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Domain
import RxSwift
import RxCocoa
import Resolver
import CoreLocation

final class MainViewModel {
    @Injected private var interactor: MeteoriteLandingInteractorInterface
    
    private let bag = DisposeBag()
}

// MARK: - Transform data flow
extension MainViewModel: ViewModelMappable {
    struct Input {
        let refreshButtonTapped: ControlEvent<Void>
    }

    struct Output {
        
    }

    func map(from input: Input) -> Output {
        input.refreshButtonTapped
            .bind { [weak self] in
                self?.fetchAnnotations()
            }
            .disposed(by: bag)
        
        return Output()
    }
}

// MARK: - Event handling
private extension MainViewModel {
    func fetchAnnotations() {
        interactor.getLandings()
            .subscribe()
            .disposed(by: bag)
    }
}
