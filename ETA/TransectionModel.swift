//
//  TransectionModel.swift
//  ETA
//
//  Created by Sonu Kumar on 21/06/23.
//

import Foundation


struct Transection : Identifiable {
    let id : Int
    let date : String
    let institution : String
    let account : String
    var marchant : String
    let amount : Double
    let type : TransectionType.RawValue
    var categoryId : Int
    var category : String
    let isPending : Bool
    var ieTransfer : Bool
    var isExpense : Bool
    var isEdited : Bool
    var dateParsed : Date {
        date.dateParsed()
    }
    
    var signedAmount : Double {
        return type == TransectionType.credit.rawValue ? amount : -amount
    }
}

enum TransectionType : String {
    case debit = "debit"
    case credit = "credit"
}
