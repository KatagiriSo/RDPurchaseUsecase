//
//  PurchaseInterface.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/11/30.
//  Copyright © 2016年 . All rights reserved.
//

import Foundation

struct PurchaseResult<T> {
    let result:T?
    let error:Error?
    
    init(error:Error) {
        result = nil
        self.error = error
    }
    
    init(result:T) {
        self.result = result
        self.error = nil
    }
}


/// 購入系インタフェース
protocol PuchaseInterface {

    // 観測開始
    func startObserve()
    
    // 購入処理
    func buy(product:PurchaseProduct,
             complete:@escaping (PurchaseResult<SKProductID>) -> Void)
    
    // リストア処理
    func restore(complete:@escaping (PurchaseResult<[SKProductID]>) -> Void)
    
    // プロダクト取得
    func fetchProduct(productIDs:Set<SKProductID>,
                      complete:@escaping (PurchaseResult<[PurchaseProduct]>) -> Void)
    
    // レシート認証
    func receiptVaridate()->Bool
    
}


