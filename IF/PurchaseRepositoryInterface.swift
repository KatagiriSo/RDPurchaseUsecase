//
//  PurchaseRepositoryInterface.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/12/01.
//  Copyright © 2016年 . All rights reserved.
//

import Foundation


protocol PurchaseRepositoryInterface {
    
    func setProductInfo(productID:SKProductID, product:PurchaseProduct)
    
    func getProductInfo(planID:PlanID) -> [PurchaseProductInfo]
    func getProductInfo(productID:SKProductID) -> [PurchaseProductInfo]
    func getPlanIDs() -> [PlanID]
    func getProductIDs() -> [SKProductID]
    func getProducts() -> [PurchaseProduct]?
}
