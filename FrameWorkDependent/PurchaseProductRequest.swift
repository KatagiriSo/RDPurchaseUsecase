//
//  PurchaseProductRequest.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/11/30.
//  Copyright © 2016年 . All rights reserved.
//

import Foundation
import StoreKit

/// プロダクトIDからのプロダクト取得処理
class PurchaseProductRequest : NSObject, SKProductsRequestDelegate {
    
    private var completeBlock:((PurchaseResult<[PurchaseProduct]>) -> Void)?
    private var response:SKProductsResponse?
    
    func fetchProduct(productIDs:Set<String>,
                      complete:@escaping (PurchaseResult<[PurchaseProduct]>) -> Void)
    {
        completeBlock = complete
        
        let product = SKProductsRequest(productIdentifiers: productIDs)
        product.delegate = self
        product.start()
    }
    
    func productsRequest(_ request: SKProductsRequest,
                         didReceive response: SKProductsResponse) {
        self.response = response
        
    }
    
    func requestDidFinish(_ request: SKRequest) {
        
        defer {
            completeBlock = nil
        }
        
        guard let completeBlock = completeBlock  else {
            return
        }
        
        guard request is SKProductsRequest else {
            completeBlock(PurchaseResult(error: PurchaseError()))
            return
        }
        
        guard  let response = response else {
            completeBlock(PurchaseResult(error: PurchaseError()))
            return
        }
        
        let products = response.products.map { PurchaseProduct.just($0) }
        completeBlock(PurchaseResult(result: products))
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        
        defer {
            completeBlock = nil
        }
        
        guard let completeBlock = completeBlock else {
            return
        }
        
        completeBlock(PurchaseResult(error: error))
    }
}
