//
//  Network.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import Foundation

final class Network {
    static let shared = Network()
    
    private init() { }
    
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
}
