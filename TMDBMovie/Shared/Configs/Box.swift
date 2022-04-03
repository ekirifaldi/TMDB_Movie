//
//  Box.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 02/04/22.
//

import Foundation

final class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value:T) {
        self.value = value
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
