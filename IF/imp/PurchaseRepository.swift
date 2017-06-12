//
//  PurchaseTranslator.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/12/01.
//  Copyright © 2016年 . All rights reserved.
//

import Foundation


/// 購入系商品情報リポジトリ
class PurchaseRepository : PurchaseRepositoryInterface{
        
    private var products:[PurchaseProductInfo] = []
    
    init(products:[PurchaseProductInfo]) {
        self.products = products
    }
    
    func getProductInfo(planID:PlanID) -> [PurchaseProductInfo] {
        return products.filter { $0.planID == planID}
    }
    
    func getProductInfo(productID:SKProductID) -> [PurchaseProductInfo] {
        return products.filter { $0.skProductID == productID}
    }
    
    func setProductInfo(productID:SKProductID, product:PurchaseProduct) {
        products = products.map {
            guard $0.skProductID == productID else {
                return $0
            }
            
            return PurchaseProductInfo(planID: $0.planID,
                                       skProductID: $0.skProductID,
                                       skProduct: product)
        }
    }
    
    func getPlanIDs() -> [PlanID] {
        return products.map {$0.planID}
    }
    
    func getProductIDs() -> [SKProductID] {
        return products.map {$0.skProductID}
    }
    
    func getProducts() -> [PurchaseProduct]? {
        let ps = products.flatMap {$0.skProduct}
        assert(ps.count == products.count, "[SKProduct].count \(products.count) != [SKProductID].count \(products.count)")
        
        guard ps.count == products.count else {
            return nil
        }
        
        return ps
    }
}



