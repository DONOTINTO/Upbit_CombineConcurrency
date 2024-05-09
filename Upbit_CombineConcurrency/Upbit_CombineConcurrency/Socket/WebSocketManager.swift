//
//  WebSocketManager.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import Foundation
import Combine

class WebSocketManager: NSObject {
    
    static let shared = WebSocketManager()
    
    private var webSocket: URLSessionWebSocketTask?
    private var isOpen = false
    
    func openWebSocket() {
        print(#function)
        
        if let url = URL(string: "wss://api.upbit.com/websocket/v1") {
            
            let session = URLSession(configuration: .default,
                                    delegate: self,
                                    delegateQueue: nil)
            
            webSocket = session.webSocketTask(with: url)
            webSocket?.resume()
        }
    }
    
    func closeWebSocket() {
        print(#function)
        
        webSocket?.cancel(with: .goingAway, reason: nil)
        webSocket = nil
        
        isOpen = false
    }
}

extension WebSocketManager: URLSessionWebSocketDelegate {
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print(#function, "Socket Open")
        
        isOpen = true
        receiveSocketData()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print(#function, "Socket Closed")
        
        isOpen = false
    }
}

extension WebSocketManager {
    
    func send(_ string: String) {
        
        webSocket?.send(.string(string)) { error in
            print(error ?? "error")
        }
    }
    
    func receiveSocketData() {
        print(#function)
        
        if isOpen {
            
            webSocket?.receive { result in
                
                switch result {
                case .success(let success):
                    print("Receive", success)
                case .failure(let failure):
                    print("Receive", failure)
                }
                self.receiveSocketData()
            }
            
        }
    }
}
