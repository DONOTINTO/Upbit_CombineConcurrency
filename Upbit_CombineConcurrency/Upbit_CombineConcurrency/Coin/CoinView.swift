//
//  CoinView.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import SwiftUI

enum JackError: Error {
    case invalidResponse
    case unknown
    case invalidImage
}

struct CoinView: View {
    
    @State private var markets: [Market] = []
    
    private var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(markets, id: \.market) { item in
                        RowView(data: item)
                    }
                }
            } // ScrollView
            .task {
                do {
                    markets = try await fetchMarket()
                } catch {
                    markets = []
                }
            }
        } // NavigationStack
    }
    
    func fetchMarket() async throws -> [Market] {
        
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

#Preview {
    CoinView()
}
