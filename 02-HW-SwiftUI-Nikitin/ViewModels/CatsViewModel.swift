//
//  CatsViewModel.swift
//  02-HW-SwiftUI-Nikitin
//
//  Created by Александр Никитин on 15.03.2023.
//

import Foundation
import Networking

    // MARK: - ViewModel
final class CatsViewModel: ObservableObject {
    @Published private(set) var cats : [Cat] = .init()
    
    var searchId : String? {
        set {
            if let newValue = newValue {
                fetchCats(withName: newValue)
                
            }
        } get {
            "searchName"
        }
        
    }
    
    init() {
        
    }
    
    func fetchCats(withName name: String){
        CatsNameAPI.getSomeCats(apiKey: "live_WqNwVcCYN2xWJt2yfNODEthqOW5JdLu6ujJMIljWzEwGRVR728imSGSIruok6oSR", limit:"20",hasBreeds: "1", breedIds: name) { data, error in
            if let cats = data {
                self.cats = cats
            }
        }
    }
}
