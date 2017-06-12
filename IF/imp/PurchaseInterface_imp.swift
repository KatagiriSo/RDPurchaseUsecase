//
//  PurchaseInterface_imp.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/12/01.
//  Copyright © 2016年 . All rights reserved.
//

import Foundation
import StoreKit

/// 購入系実装
class PurchaseInterface_imp : NSObject, PuchaseInterface {
    
    let observer : PurchaseQueueObserver
    let receiptVaridater : PurchaseReceiptVaridator
    var request : PurchaseProductRequest?

    convenience override init() {

        let observer = PurchaseQueueObserver()
        let receiptVaridater = PurchaseReceiptVaridator(delegate: nil)
        
        self.init(observer:observer, receiptVaridater:receiptVaridater)
    }
    
    required init(observer:PurchaseQueueObserver,
                  receiptVaridater:PurchaseReceiptVaridator) {
        
        self.observer = observer
        self.receiptVaridater = receiptVaridater
    }
    
    /// 監視開始
    func startObserve() {
        self.observer.finishObserve()
        self.observer.startObserve()
    }
    
    /// 購入
    func buy(product:PurchaseProduct,
             complete:@escaping (PurchaseResult<SKProductID>) -> Void) {
        
        let payment = SKPayment(product: product.getSKProduct()!)
        
        observer.buy(payment: payment, complete: complete)
        
    }
    
    /// リストア
    func restore(complete:@escaping (PurchaseResult<[SKProductID]>) -> Void) {
        
        observer.restore(complete: complete)
    }
    
    
    /// 商品情報取得
    func fetchProduct(productIDs:Set<SKProductID>,
                      complete:@escaping (PurchaseResult<[PurchaseProduct]>) -> Void) {
        
        request = PurchaseProductRequest()
        request?.fetchProduct(productIDs: productIDs,
                              complete: complete)
    }
    
    /// レシート検証
    func receiptVaridate()->Bool {
        return self.receiptVaridater.varidate()
    }
    
}

