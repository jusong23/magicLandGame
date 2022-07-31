//
//  GuestDataModel.swift
//  Thread_Example_Project
//
//  Created by 이주송 on 2022/07/30.
//

import Foundation

class GuestDataModel {
    public var arrayGuestStruct: [GuestStruct] = [
        GuestStruct(Bakery: 1, Coffee: 1, Smoothie: 1)
    ]
    
    public func numberOfGuest() -> Int {
        return self.arrayGuestStruct.count
    }

    public func inputData(Bakery: Int, Coffee: Int, Smoothie: Int) {
        self.arrayGuestStruct.append(GuestStruct(Bakery: Bakery, Coffee: Coffee, Smoothie: Smoothie))
    }
    
    public func removeData(index: Int) {
        self.arrayGuestStruct.remove(at: index)
    }
}
