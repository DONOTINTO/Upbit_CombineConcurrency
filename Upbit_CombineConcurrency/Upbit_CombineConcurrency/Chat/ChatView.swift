//
//  ChatView.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/17/24.
//

import SwiftUI

struct ChatView: View {
    
    @State private var newMessage = ""
    @State private var chatList: [Chat] = []
    
    var body: some View {
        
        VStack {
            
            List(chatList, id: \.id) { value in
                DummyChattingView(chat: value)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
            HStack {
                
                TextField("내용을 입력해주세요", text: $newMessage)
                Button(action: sendMessage, label: {
                    Image(systemName: "paperplane")
                })
                
            }.padding()
        }
        .task {
            // db에서 상대방과의 채팅내역을 read
            // db에서 가장 최근 대화 날짜 기준으로 조회
            // 가장 마지막 대화 이후에 새로 온 데이터가 있는 지 확인(server)
            // 새로 온 데이터를 db에 저장하고 다시 가지고 오기
            // 이후에 소켓 연결..
            chatList = DummyData.messages
        }
    }
    
    // API post >> 200 응답값을 db에 저장
    // 저장된 db내용을 다시 가져와서 view에 보여주기
    func sendMessage() {
        if !newMessage.isEmpty {
            
            let chat = Chat(content: newMessage, isUser: true)
            chatList.append(chat)
            
            newMessage = ""
        }
        
        
    }
}

#Preview {
    ChatView()
}
