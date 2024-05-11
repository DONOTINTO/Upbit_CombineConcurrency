//
//  ChartView.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import SwiftUI

struct ChartView: View {
    
    @StateObject var viewModel = ChartViewModel()
    
    var body: some View {
        VStack {
            
            Button("소켓 종료") {
                WebSocketManager.shared.closeWebSocket()
            }
            
            ForEach(viewModel.askOrderBook, id: \.id) { item in
                Text(item.price.formatted())
            }
            .background(Color.blue.opacity(0.2))
            
            ForEach(viewModel.bidOrderBook, id: \.id) { item in
                Text(item.price.formatted())
            }
            .background(Color.red.opacity(0.2))
        }
    }
}

#Preview {
    ChartView()
}
