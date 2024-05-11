//
//  ChartViewModel.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/10/24.
//

import Foundation
import Combine

final class ChartViewModel: ObservableObject {
    
    private var cancellable = Set<AnyCancellable>()
    
    @Published
    var askOrderBook: [OrderBookItem] = []
    
    @Published
    var bidOrderBook: [OrderBookItem] = []
    
    init() {
        
        WebSocketManager.shared.openWebSocket()
        
        WebSocketManager.shared.send("""
[{"ticket":"test"},{"type":"orderbook","codes":["KRW-BTC"]}]
""")
        WebSocketManager.shared.orderbookSbj
            .sink { [weak self] order in
                
                guard let self else { return }
                
                self.askOrderBook = order.orderbookUnits.map {
                    .init(price: $0.askPrice, size: $0.askSize)
                }
                .sorted { $0.price > $1.price }
                
                self.bidOrderBook = order.orderbookUnits.map {
                    .init(price: $0.bidPrice, size: $0.bidSize)
                }
                .sorted { $0.price > $1.price }
            }
            .store(in: &cancellable)
    }
    
    deinit {
        WebSocketManager.shared.closeWebSocket()
    }
}
