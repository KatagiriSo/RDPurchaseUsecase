//
//  PurchaseUseCase_Restore.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/12/01.
//  Copyright © 2016年 . All rights reserved.
//

import Foundation

/// リストア機能
class PurchaseUseCase_Restore : PurchaseUseCase {
    
    func start(complete:@escaping (Error?)->Void) {
        
        let IF = PurchaseAllocator.share.purchaseIF
        
        IF.restore { (result:PurchaseResult<[SKProductID]>) in
            
            if let error = result.error {
                complete(error)
                return
            }
            
            guard let productIDs = result.result else {
                complete(PurchaseError())
                return
            }
            
            guard productIDs.count != 0  else {
                complete(PurchaseError())
                return
            }
            
            // list更新
            
            complete(nil)
            
        }
        
        
    }
    
}
