//
//  PurchaseAllocater.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/12/01.
//  Copyright © 2016年 . All rights reserved.
//

import Foundation

/// 購入系シングルトン
struct PurchaseAllocator  {
    
    let repository:PurchaseRepositoryInterface
    let purchaseIF:PuchaseInterface
    
    static let share:PurchaseAllocator = {

        let repo = PurchaseRepository(products: OosakaProducts.get())
        let purchaseIF = PurchaseInterface_imp()
        let allocator = PurchaseAllocator(repository: repo, purchaseIF: purchaseIF)
        
        return allocator
    }()
    
}
