//
//  DynamicFontSize.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit

struct DynamicFontSize {
    
    var calculatedFontSize: CGFloat!
    
    init(fontSize: CGFloat){
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        switch height {
        case 480.0: //Iphone 3,4,SE => 3.5 inch
            calculatedFontSize = fontSize * 0.7
            break
        case 568.0: //iphone 5, 5s => 4 inch
            calculatedFontSize = fontSize * 0.8
            break
        case 667.0: //iphone 6, 6s => 4.7 inch
            calculatedFontSize = fontSize * 0.9
            break
        case 736.0: //iphone 6s+ 6+ => 5.5 inch
            calculatedFontSize = fontSize * 0.988
            break
        default:
            calculatedFontSize = fontSize
//            print("Bigger iPhone")
            break
        }
    }
}
