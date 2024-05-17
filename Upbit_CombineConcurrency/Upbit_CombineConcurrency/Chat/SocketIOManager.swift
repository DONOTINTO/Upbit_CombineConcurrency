//
//  SocketIOManager.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/17/24.
//

import Foundation
import SocketIO
import Combine

struct RealChat: Decodable, Hashable {
    
    let content: String
    let createdAt: String
}

final class SocketIOManager {
    
    static let shared = SocketIOManager()
    
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    let baseURL = URL(string: "http://lslp.sesac.kr:8244/v1")!
    let roomID = "/chats-6646b2192b0224d65614ac86"
    
    var receivedChatData = PassthroughSubject<RealChat, Never>()
    
    private init() {
        
        manager = SocketManager(socketURL: baseURL)
        
        socket = manager.socket(forNamespace: roomID)
        
        socket.on(clientEvent: .connect) { data, ack in
            print("socket connected")
        }
        
        socket.on(clientEvent: .disconnect) { data, ack in
            print("socket disconnected")
        }
        
        // [Any] > Data > Struct
        socket.on("chat") { [weak self] data, ack in
            
            guard let self else { return }
            
            print("chat received")
            
            if let data = data.first {
                let result = try? JSONSerialization.data(withJSONObject: data)
                
                let decodedData = try? JSONDecoder().decode(RealChat.self, from: result!)
                
                self.receivedChatData.send(decodedData!)
            }
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func leaveConnection() {
        socket.disconnect()
    }
}
