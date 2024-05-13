//
//  UserDefaultsGroup.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/13/24.
//

import Foundation

extension UserDefaults {
    
    static var groupShared: UserDefaults {
        
        let appGroupID = "group.com.donotinto"
        return UserDefaults(suiteName: appGroupID)!
    }
}
