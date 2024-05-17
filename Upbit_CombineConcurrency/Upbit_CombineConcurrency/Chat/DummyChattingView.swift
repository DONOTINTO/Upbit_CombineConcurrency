//
//  DummyChattingView.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/17/24.
//

import SwiftUI

struct DummyChattingView: View {
    
    var chat: Chat
    
    var body: some View {
        HStack(spacing: 10) {
            
            if chat.isUser {
                Spacer()
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            
            Text(chat.content)
                .padding()
                .foregroundStyle(chat.isUser ? Color.white : Color.black)
                .background(chat.isUser ? Color.blue : Color.gray.opacity(0.5))
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    DummyChattingView(chat: Chat(content: "Test123123123123", isUser: false))
}
