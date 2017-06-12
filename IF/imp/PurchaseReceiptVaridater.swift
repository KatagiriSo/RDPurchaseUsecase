//
//  PurchaseReceiptVaridater.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/11/30.
//  Copyright © 2016年 . All rights reserved.
//

import Foundation

protocol PurchaseVaridateAPI {
   func verify(receipt:String) -> Bool
}

/// レシート検証処理
class PurchaseReceiptVaridator {
    
    var delegate:PurchaseVaridateAPI? = nil
    
    init(delegate:PurchaseVaridateAPI?) {
        self.delegate = delegate
    }

    func varidate() -> Bool {
        
        guard let receiptStr = getReceipt() else {
            return false
        }
        
        guard let delegate = delegate else {
            return false
        }
        
        return delegate.verify(receipt: receiptStr)
    }
    
    
    private func getReceipt()-> String? {
        
        if let url = Bundle.main.appStoreReceiptURL {
            if let receiptData = NSData(contentsOf: url) {
                let receiptStr = receiptData.base64EncodedString()
                return receiptStr
            }
        }
        
        return nil
    }
}
