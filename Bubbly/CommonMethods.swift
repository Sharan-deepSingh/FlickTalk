//
//  CommonMethods.swift
//  FlickTalk
//
//  Created by Sharandeep Singh on 07/10/24.
//

import Foundation

class CommonMethods {
    
    static func getCornerRadius(forHeight height: Double) -> Double {
        /// Logic Explanation : - I have noticed by hit and trial method that corner radius between
        /// 10 - 19 for height something between 0 - 99 looks good. So based on this observation
        /// I have build below logic to generate approximate good looking corner radius.
        let stringHeight = "\(Int(height))"
        let placesCount = stringHeight.count
        let offSet = Double(String(stringHeight.first ?? "0")) ?? 0.0
        let cornerRadius = Double((placesCount - 1) * 10) + offSet
        
//        return cornerRadius
        return 12
    }
}
