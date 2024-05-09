//
//  Market.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import Foundation

struct Market: Hashable, Decodable {
    
    let market, koreanName, englishName: String
    
    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
