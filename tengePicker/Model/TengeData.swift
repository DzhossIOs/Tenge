//
//  TengeData.swift
//  tengePicker
//
//  Created by Zhastalap Aldanysh on 7/11/20.
//  Copyright © 2020 Zhastalap Aldanysh. All rights reserved.
//

import Foundation

struct TengeData: Codable{

    var rates: RatesCurrency
    
}

struct RatesCurrency: Codable{
    let USD: Double
    let EUR: Double
    let PLN: Double
    let CAD: Double
    let RUB: Double
    let KZT: Double
}

