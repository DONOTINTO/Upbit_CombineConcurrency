//
//  RowView.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import SwiftUI

struct RowView: View {
    
    let data: Market
    
    var body: some View {
        LazyVStack {
            Text(data.koreanName)
                .fontWeight(.bold)
            Text(data.market)
                .font(.caption)
                .foregroundStyle(.gray)
            Text(data.englishName)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
        // .frame(maxWidth: .infinity, maxHeight: 130)
        .background(.yellow)
    }
}

// #Preview {
//     RowView()
// }
