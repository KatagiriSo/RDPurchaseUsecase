//
//  PurchaseProductInfo.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/12/01.
//  Copyright © 2016年 rodhos. All rights reserved.
//

import Foundation

typealias PlanID = String

struct PurchaseProductInfo {
    var planID:PlanID
    var skProductID:SKProductID
    var skProduct:PurchaseProduct?
}
