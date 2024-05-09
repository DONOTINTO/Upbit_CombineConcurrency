//
//  CoinCombineViewModel_v2.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import Foundation
import Combine

// disposeBag <-> AnyCancellable

// subcribe <-> sink
// dispose <-> store

// Rx -> observable - observer - operator
// Combine -> publisher - subscriber - operator

// observerOn <-> receiveOn

// publishSubject <-> PassThroughSubject
// behaviorSubject <-> CurrentValueSubject

class CoinCombineViewModel_v2: ViewModelType {
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published
    var output = Output()
    
    init() {
        transform()
    }
}


extension CoinCombineViewModel_v2 {
    
    struct Input {
        var viewOnAppear = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var market: [Market] = []
    }
    
    //transform
    func transform() {
        
        input.viewOnAppear
            .sink { [weak self] _ in
                
                // 통신 후 마켓 정보를 Output로 전달
                guard let self else { return }
                
                Task { try? await self.fetchMarket() }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func fetchMarket() async throws {
        do {
            output.market = try await Network.shared.requestUpbitAPI()
        } catch {
            output.market = []
        }
    }
}
