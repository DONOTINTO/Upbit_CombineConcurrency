//
//  CoinCombineView.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import SwiftUI
import WidgetKit

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
                            .onTapGesture {
                                
                                print("이 전")
                                print(UserDefaults.groupShared.string(forKey: "KoreanName") ?? "데이터 없음")
                                print(UserDefaults.standard.string(forKey: "KoreanName") ?? "데이터 없음")
                                
                                UserDefaults.groupShared.set(item.koreanName, forKey: "KoreanName")
                                UserDefaults.groupShared.set(item.market, forKey: "Market")
                                
                                print("이 후")
                                print(UserDefaults.groupShared.string(forKey: "KoreanName") ?? "데이터 없음")
                                print("===========================")
                                
                                
                                WidgetCenter.shared.reloadTimelines(ofKind: "StaticWidget")
                            }
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
