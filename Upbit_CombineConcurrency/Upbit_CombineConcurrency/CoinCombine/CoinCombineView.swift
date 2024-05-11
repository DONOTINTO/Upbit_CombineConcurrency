//
//  CoinCombineView.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import SwiftUI

struct CoinCombineView: View {
    
    @StateObject
    var viewModel = CoinCombineViewModel_v2()
    
    private var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.output.market, id: \.market) { item in
                        RowView(data: item)
                    }
                }
            } // ScrollView
            .task {
                // viewModel.input.viewOnAppear.send(())
                viewModel.action(.viewOnAppear)
            }
        } // NavigationStack
    }
}

#Preview {
    CoinCombineView()
}
