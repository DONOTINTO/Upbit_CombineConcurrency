//
//  CoinViewModel.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import Foundation

@MainActor
class CoinViewModel: ObservableObject {
    
    @Published var markets: [Market] = []

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
    
    func fetchMarket() async throws {
        do {
            markets = try await requestUpbitAPI()
        } catch {
            markets = []
        }
    }
}
