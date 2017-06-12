//
//  PurchaseUseCase_Buy.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/12/01.
//  Copyright © 2016年 . All rights reserved.
//

import Foundation

/// 購入機能
class PurchaseUseCase_Buy : PurchaseUseCase {
    
    let productID:SKProductID
    
    init(productID:SKProductID) {
        self.productID = productID
    }
    
    func start(complete:@escaping (Error?)->Void) {
        let r = PurchaseAllocator.share.repository
        let IF = PurchaseAllocator.share.purchaseIF
        
        guard let product = r.getProductInfo(productID: productID).first?.skProduct else {
            complete(PurchaseError())
            return
        }
        
        
        IF.buy(product: product) {(result:PurchaseResult<SKProductID>) -> Void in
            if let error = result.error {
                complete(error)
                return
            }
            
            guard result.result != nil  else {
                complete(PurchaseError())
                return
            }
            
            guard IF.receiptVaridate() else {
                complete(PurchaseError())
                return
            }
            
            // list更新
            complete(nil)
        }
    }
    
}
