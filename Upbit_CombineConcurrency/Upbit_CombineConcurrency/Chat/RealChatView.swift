//
//  RealChatView.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/17/24.
//

import SwiftUI

struct RealChatView: View {
    
    @StateObject var viewModel = RealChatViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.messages, id: \.self) { chat in
                Text(chat.content)
                    .padding()
                    .background(Color.gray.opacity(0.5))
            }
            Button("소켓 해제") {
                SocketIOManager.shared.leaveConnection()
            }
        }
        .task {
            SocketIOManager.shared
                .establishConnection()
        }
    }
}

#Preview {
    RealChatView()
}
