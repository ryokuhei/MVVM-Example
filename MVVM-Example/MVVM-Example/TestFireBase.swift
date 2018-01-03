//
//  TestFireBase.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/23.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import Firebase

class TestFireBase {
    
    var DBRef: DatabaseReference!

    init() {
        DBRef  = DatabaseReference()
    }
    
    func setValue(value : String) {
        
        print("FireBase setValue \(value)")
        DBRef.child("user/01").setValue(["val": value])
        
        print("seValue :\(value)")

    }
    
    func getValue() -> String {
        
        var value = ""
        
        let defaultPlace = DBRef.child("test")
        defaultPlace.observe(.value) { (snap :DataSnapshot) in
            value = snap.value as? String ?? ""
        }
        return value
    }
    
    func updateValue(value: String) {
        
        DBRef.child("test").updateChildValues(["val": value])
        
    }
    
    func deleteValue() {
        DBRef.child("test/val").removeValue()
    }
}
