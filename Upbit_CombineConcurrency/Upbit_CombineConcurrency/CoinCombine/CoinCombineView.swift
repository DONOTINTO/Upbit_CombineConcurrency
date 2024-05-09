//
//  CoinCombineView.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import SwiftUI

struct CoinCombineView: View {
    
    // @StateObject
    var viewModel: ViewModelType
    
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
                print("view On Appear")
                viewModel.input.viewOnAppear.send(())
            }
        } // NavigationStack
    }
}

#Preview {
    CoinCombineView()
}
