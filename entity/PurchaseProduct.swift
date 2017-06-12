//
//  PurchaseProduct.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/12/01.
//  Copyright © 2016年 rodhos. All rights reserved.
//

import Foundation
import StoreKit


extension SKProduct : SKProductInterface {
    
}


enum PurchaseProduct:SKProductInterface {
    
    case just(SKProduct)
    case dummy(SKProductInterface)
    
    func get()->SKProductInterface {
        switch self {
        case .just(let x):
            return x
        case .dummy(let x):
            return x
        }
    }
    
    func getSKProduct() -> SKProduct? {
        switch self {
        case .just(let x):
            return x
        default:
            return nil
        }
    }
    
    internal var downloadContentVersion: String {
        get {
                return self.get().downloadContentVersion
            }
    }

    internal var downloadContentLengths: [NSNumber] {
        get {
            return self.get().downloadContentLengths
        }
    }

    internal var isDownloadable: Bool {
        get {
            return self.get().isDownloadable
        }
    }

    internal var productIdentifier: String {
        get {
            return self.get().productIdentifier
        }
    }

    internal var priceLocale: Locale {
        get {
            return self.get().priceLocale
        }
    }

    internal var price: NSDecimalNumber {
        get {
            return self.get().price
        }
    }

    internal var localizedTitle: String {
        get {
            return self.get().localizedTitle
        }
    }

    internal var localizedDescription: String {
        get {
            return self.get().localizedDescription
        }
    }

}
