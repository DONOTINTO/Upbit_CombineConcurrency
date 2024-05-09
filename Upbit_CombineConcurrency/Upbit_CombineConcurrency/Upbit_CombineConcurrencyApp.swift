//
//  Upbit_CombineConcurrencyApp.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import SwiftUI

@main
struct Upbit_CombineConcurrencyApp: App {
    var body: some Scene {
        WindowGroup {
            ChartView(viewModel: CoinCombineViewModel_v2())
        }
    }
}
