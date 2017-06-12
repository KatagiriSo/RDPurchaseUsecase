//
//  PurchaseQueue.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/11/30.
//  Copyright © 2016年 . All rights reserved.
//

import Foundation
import StoreKit

typealias SKProductID = String

enum PurchaseQueueMode {
    
    case None
    case Restore((PurchaseResult<[SKProductID]>)->Void)
    case Payment(SKPayment,(PurchaseResult<SKProductID>)->Void)
}

/// SKPaymentQueueの操作と監視処理
class PurchaseQueueObserver : NSObject {
    
    var mode:PurchaseQueueMode = .None
    
    /// 監視開始
    func startObserve() {
        SKPaymentQueue.default().add(self)
    }
    
    /// 監視終了
    func finishObserve() {
        SKPaymentQueue.default().remove(self)
    }
    
    /// 購入処理
    func buy(payment:SKPayment, complete:@escaping (PurchaseResult<SKProductID>)->Void) {
        
        /// 購入もリストアもしていないこと
        guard case .None = mode else {
            complete(PurchaseResult(error: PurchaseError()))
            return
        }
        
        /// iPhoneが購入できる設定なこと
        guard SKPaymentQueue.canMakePayments() else {
            complete(PurchaseResult(error: PurchaseError()))
            return
        }
        
        /// トランザクションが何もないこと
        guard SKPaymentQueue.default().transactions.count == 0 else {
            
            /// トランザクションを全て終了させる
            SKPaymentQueue.default().transactions.forEach {
                SKPaymentQueue.default().finishTransaction($0)
            }
            complete(PurchaseResult(error: PurchaseError()))
            return
        }
        
        mode = .Payment(payment,complete)
        SKPaymentQueue.default().add(payment)
        
        return
    }
    
    /// リストア処理
    func restore(complete:@escaping (PurchaseResult<[SKProductID]>)->Void) {
        
        guard case .None = mode else {
            complete(PurchaseResult(error: PurchaseError()))
            return
        }
        
        guard SKPaymentQueue.default().transactions.count == 0 else {
            complete(PurchaseResult(error: PurchaseError()))
            return
        }
        
        mode = .Restore(complete)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
}


extension PurchaseQueueObserver : SKPaymentTransactionObserver {
    
    /// トランザクションに変化があった。
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        switch mode {
        
        /// モード未設定の場合は異常系とみなし全て終了する。
        case .None:
            transactions.forEach {
                queue.finishTransaction($0)
            }
            
        ///　リストアモードの場合はリストア終了時に処理を行う。
        case .Restore(_):
            break
            
        /// 購入モードの場合は購入成功、失敗を判断する。
        case .Payment(let payment, let block):
            
            /// 購入は常にトランザクションが一つ
            guard transactions.count == 1,
                let transaction = transactions.first,
                payment.productIdentifier == transaction.payment.productIdentifier else {
                
                transactions.forEach {
                    queue.finishTransaction($0)
                }
                
                block(PurchaseResult(error: PurchaseError()))
                mode = .None
                return
            }
            
            switch transaction.transactionState {
            case .purchased:
                queue.finishTransaction(transaction)
                block(PurchaseResult(result: payment.productIdentifier))
                mode = .None
            case .failed:
                queue.finishTransaction(transaction)
                block(PurchaseResult(error: PurchaseError()))
                
            default:
                break
            }
        }
        
        
    }
    
    /// トランザクションが除かれた
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        
    }
    
    /// リストアが完了した
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
        let transactions = queue.transactions
        
        let restoredProductIDs = transactions.filter { $0.transactionState == .restored }
                                            .map { $0.payment.productIdentifier }
        
        /// トランザクション終了
        transactions.forEach {
            queue.finishTransaction($0)
        }
        
        /// 通知
        if case .Restore(let block) = mode {
            block(PurchaseResult(result: restoredProductIDs))
            mode = .None
        } else {
            assert(false,"restore complete mode.Restore != \(mode)")
            mode = .None
        }
    }
    
    /// リストアが失敗して完了した。
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        
        let transactions = queue.transactions

        transactions.forEach {
            queue.finishTransaction($0)
        }
        
        if case .Restore(let block) = mode {
            block(PurchaseResult(error:error))
            mode = .None
        } else {
            assert(false,"restore error complete mode.Restore != \(mode)")
            mode = .None
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedDownloads downloads: [SKDownload]) {
    }
}


