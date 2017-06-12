//
//  PurchaseUseCase_Buy.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/12/01.
//  Copyright © 2016年 . All rights reserved.
//

import Foundation

protocol PurchaseUseCase {
    
}

/// 初期化機能
/// プロダクト取り出し、レシート検証、list更新
class PurchaseUseCase_Initialize : PurchaseUseCase {
    
    func start(complete:@escaping (Error?)->Void) {
        
        let r = PurchaseAllocator.share.repository
        let IF = PurchaseAllocator.share.purchaseIF
        
        IF.startObserve()
        let productIDs = r.getProductIDs()
        let productIDsSet = Set<SKProductID>(productIDs)
        IF.fetchProduct(productIDs: productIDsSet) {(result:PurchaseResult<[PurchaseProduct]>) -> Void in
            
            if let error = result.error {
                complete(error)
                return
            }
            
            let products = result.result
            products?.forEach {
                r.setProductInfo(productID: $0.productIdentifier, product: $0)
            }
            
            // レシート検証
            guard IF.receiptVaridate() else {
                complete(PurchaseError())
                return
            }
            
            // list更新
            complete(nil)
        }
        
        
    }
}

