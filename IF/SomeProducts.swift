//
//  PurchaseRepository_Some.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/12/01.
//  Copyright © 2016年 . All rights reserved.
//

import Foundation


let planID_planA:PlanID = "hoge"
let skProductID_planA:SKProductID = "fuga"

let planID_planB:PlanID = "hoge2"
let skProductID_planB:SKProductID = "fuga2"

struct SomeProducts {
    static func get()->[PurchaseProductInfo] {
        let planA : PurchaseProductInfo = PurchaseProductInfo(planID: planID_planA,
                                                              skProductID: skProductID_planA,
                                                              skProduct: nil)
        
        let planB : PurchaseProductInfo = PurchaseProductInfo(planID: planID_planB,
                                                              skProductID: skProductID_planB,
                                                              skProduct: nil)
        
        return [planA, planB]
    }
}
