//
//  TimeModel.swift
//  BookeTime
//
//  Created by Solomon  on 29.04.2023.
//

import RealmSwift
import Foundation


class TimeModel: Object {
    
//    @Persisted var actualStartTime: Int = 0
    @objc dynamic var actualStartTime: Int = 0
    
}

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveModel(model: TimeModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
        
    func deleteModel(model: Int) {
        let result = localRealm.objects(TimeModel.self).filter("actualStartTime == %@", model).first
        if let result = result {
            try! localRealm.write {
                localRealm.delete(result)
            }
        }
    }
    
}
