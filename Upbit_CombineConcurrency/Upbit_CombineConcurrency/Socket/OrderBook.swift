//
//  OrderBook.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/10/24.
//

import Foundation

struct OrderBook: Decodable {
    
    // let market: String
    let timestamp: Int
    let totalAskSize: Double
    let totalBidSize: Double
    let orderbookUnits : [OrderBookUnit]
    
    enum CodingKeys: String, CodingKey {
        // case market
        case timestamp
        case totalAskSize = "total_ask_size"
        case totalBidSize = "total_bid_size"
        case orderbookUnits = "orderbook_units"
    }
}

struct  OrderBookUnit: Decodable {
    let askPrice: Double
    let bidPrice: Double
    let askSize: Double
    let bidSize: Double
    
    enum CodingKeys: String, CodingKey {
        case askPrice = "ask_price"
        case bidPrice = "bid_price"
        case askSize = "ask_size"
        case bidSize = "bid_size"
    }
}

struct OrderBookItem: Hashable, Identifiable {
    let id = UUID()
    let price: Double
    let size: Double
}
