//
//  ChartView.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import SwiftUI

struct ChartView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                
                WebSocketManager.shared.openWebSocket()
                
                WebSocketManager.shared.send("""
      [{"ticket":"test"},{"type":"orderbook","codes":["KRW-BTC"]}]
      """)
            }
        Button {
            WebSocketManager.shared.closeWebSocket()
        } label: {
            Text("종료")
        }

    }
}

#Preview {
    ChartView()
}
