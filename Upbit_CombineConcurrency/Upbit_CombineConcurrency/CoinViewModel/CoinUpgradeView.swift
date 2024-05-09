//
//  CoinUpgradeView.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import SwiftUI

struct CoinUpgradeView: View {
    
    @StateObject var viewModel = CoinViewModel()
    
    private var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.markets, id: \.market) { item in
                        RowView(data: item)
                    }
                }
            } // ScrollView
            .task {
                Task {
                    try? await viewModel.fetchMarket()
                }
            }
        } // NavigationStack
    }
}

#Preview {
    CoinUpgradeView()
}
