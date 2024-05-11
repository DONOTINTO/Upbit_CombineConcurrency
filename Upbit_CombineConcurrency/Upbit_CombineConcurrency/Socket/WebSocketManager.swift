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
    
    private var timer: Timer?
    
    var orderbookSbj = PassthroughSubject<OrderBook, Never>()
    
    func openWebSocket() {
        print(#function)
        
        if let url = URL(string: "wss://api.upbit.com/websocket/v1") {
            
            let session = URLSession(configuration: .default,
                                    delegate: self,
                                    delegateQueue: nil)
            
            webSocket = session.webSocketTask(with: url)
            
            // 소켓 연결요청
            webSocket?.resume()
        }
    }
    
    func closeWebSocket() {
        print(#function)
        
        webSocket?.cancel(with: .goingAway, reason: nil)
        webSocket = nil
        
        timer?.invalidate()
        timer = nil
        
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
                
                // MARK: Result Switch
                switch result {
                case .success(let success):
                    print("Receive", success)
                
                    // MARK: Success Switch
                    switch success {
                    case .data(let data):
                        
                        if let decodedData = try? JSONDecoder().decode(OrderBook.self, from: data) {
                            
                            self.orderbookSbj.send(decodedData)
                        } else {
                            print("디코딩 실패")
                        }
                    
                    case .string(let string):
                        print(string)
                        
                    // MARK: success가 Frozen이 아니기 때문에 필요함
                    @unknown default:
                        fatalError()
                    }
                    
                case .failure(let failure):
                    print("Receive", failure)
                }
                self.receiveSocketData()
            }
            
        }
    }
    
    // 서버에 의해 연결이 끊어지지 않도록 주기적으로 ping을 서버에 보내주는 작업도 추가
    func ping() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { [weak self] _ in
            
            self?.webSocket?.sendPing { error in
                if let error {
                    print("ping pong error", error.localizedDescription)
                } else {
                    print("ping ping ping")
                }
            }
        })
    }
}
