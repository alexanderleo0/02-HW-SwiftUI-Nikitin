//
//  Deals+Identifiable.swift
//  02-HW-SwiftUI-Nikitin
//
//  Created by Александр Никитин on 22.03.2023.
//

import Foundation
import Networking

extension Deals : Identifiable {
    public var id: String {
        return dealID
    }
    
    
}
