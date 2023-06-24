//
//  PreviewData.swift
//  ETA
//
//  Created by Sonu Kumar on 21/06/23.
//

import Foundation

var transectionPreviewData = Transection(id: 1, date: "01/24/2023", institution: "GGU", account: "SBI", merchant: "Paytm", amount: 13800, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false )

var transectionListPreviewdata = [Transection](repeating: transectionPreviewData, count: 10)
