//
//  GuestDataModel.swift
//  Thread_Example_Project
//
//  Created by 이주송 on 2022/07/30.
//

import Foundation

class GuestDataModel {
    public var arrayGuestStruct: [GuestStruct] = [
        
    ]
    
    public func numberOfBakery(index:Int) -> Int {
        return self.arrayGuestStruct[index].Bakery!
    }
    
    public func numberCoffee(index:Int) -> Int {
        return self.arrayGuestStruct[index].Coffee!
    }
    
    public func numberOfSmoothie(index:Int) -> Int {
        return self.arrayGuestStruct[index].Smoothie!
    }
    
    public func numberOfGuest() -> Int {
        return self.arrayGuestStruct.count
    }

    public func inputData(Bakery: Int, Coffee: Int, Smoothie: Int) {
        self.arrayGuestStruct.append(GuestStruct(Bakery: Bakery, Coffee: Coffee, Smoothie: Smoothie))
    }
    
    public func removeData() {
        self.arrayGuestStruct.removeFirst()
    }
}
