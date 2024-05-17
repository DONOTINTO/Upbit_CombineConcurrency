//
//  DummyData.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/17/24.
//

import Foundation

struct Chat:Hashable, Identifiable {
    
    var content: String
    var isUser: Bool
    var id = UUID()
    
    init(content: String, isUser: Bool) {
        self.content = content
        self.isUser = isUser
    }
}

struct DummyData {
    
    static let messages = [
        
        Chat(content: "안녕 그동안 잘 지냈니", isUser: true),
        
        Chat(content: "영등포야 나야", isUser: false),
        Chat(content: "당연히 나지", isUser: true),
        Chat(content: "Dearest, Darling, My universe 날 데려가 줄래? 나의 이 가난한 상상력으론 떠올릴 수 없는 곳으로 저기 멀리 from Earth to Mars 꼭 같이 가줄래? 그곳이 어디든, 오랜 외로움 그 반대말을 찾아서 어떤 실수로 이토록 우리는 함께일까 세상에게서 도망쳐 Run on 나와 저 끝까지 가줘 My lover 나쁜 결말일까 길 잃은 우리 둘 um 부서지도록 나를 꼭 안아", isUser: false),
        Chat(content: "뭐래", isUser: true),
        Chat(content: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ", isUser: false),
        Chat(content: "ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ", isUser: true),
        Chat(content: "...", isUser: false)
        
    ]
}
