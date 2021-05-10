//
//  StringHelper.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import Foundation

struct StringHelper {
    func toStringRoundUp(num: Double) -> String {
        return "\(String(format: "%.1f", locale: Locale.init(identifier: "us"), ceil(num*100)/100))"
    }
}
