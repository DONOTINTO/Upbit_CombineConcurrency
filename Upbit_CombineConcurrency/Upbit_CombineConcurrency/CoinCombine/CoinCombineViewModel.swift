//
//  CoinCombineViewModel.swift
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

class CoinCombineViewModel: ObservableObject {
    
    // disposebag
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published
    var output = Output()
    
    struct Input {
        var viewOnAppear = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var market: [Market] = []
    }
    
    init() {
        print("init")
        transform()
    }
}


extension CoinCombineViewModel {
    
    //transform
    func transform() {
        
        print("transform")
        input.viewOnAppear
            .sink { [weak self] _ in
                print("view On Appear Sink")
                // 통신 후 마켓 정보를 Output로 전달
                guard let self else { return }
                
                Task { try? await self.fetchMarket() }
            }
            .store(in: &cancellables)
    }
    
    func requestUpbitAPI() async throws -> [Market] {
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw JackError.unknown
        }
        
        let market = try JSONDecoder().decode([Market].self, from: data)
        
        return market
    }
    
    @MainActor
    func fetchMarket() async throws {
        do {
            output.market = try await requestUpbitAPI()
        } catch {
            output.market = []
        }
    }
}
