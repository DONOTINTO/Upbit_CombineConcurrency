//
//  RealChatViewModel.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/17/24.
//

import Foundation
import Combine

// SocketIOManager > ReceivedChatData > subscribe > view

final class RealChatViewModel: ObservableObject {
    
    var cancellable = Set<AnyCancellable>()
    
    @Published
    var messages: [RealChat] = []
    
    init() {
        SocketIOManager.shared.receivedChatData
            .sink { realChat in
                self.messages.append(realChat)
            }
            .store(in: &cancellable)
    }
}
