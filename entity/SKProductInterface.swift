//
//  SKProductInterface.swift
//  PurchaseSample
//
//  Created by 片桐奏羽 on 2016/12/01.
//  Copyright © 2016年 rodhos. All rights reserved.
//

import Foundation

protocol SKProductInterface {
    
    var localizedDescription: String { get }
    var localizedTitle: String { get }
    var price: NSDecimalNumber { get }
    var priceLocale: Locale { get }
    var productIdentifier: String { get }
    var isDownloadable: Bool { get }
    var downloadContentLengths: [NSNumber] { get }
    var downloadContentVersion: String { get }
}
