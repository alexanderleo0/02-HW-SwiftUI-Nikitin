//
//  BreedsViewModel.swift
//  02-HW-SwiftUI-Nikitin
//
//  Created by Александр Никитин on 15.03.2023.
//

import Foundation
import Networking

    // MARK: - ViewModel

final class BreedsViewModel: ObservableObject {
    
    @Published private(set) var catsBreeds : [Breeds] = .init()

    init() {
        fetchBreeds()
    }

    func fetchBreeds(){
        debugPrint("start fetching breeds")
        BreedsAPI.breedsGet { data, error in
            if let breeds = data {
                self.catsBreeds = breeds
                for (index, breed) in breeds.enumerated() {
                    if breed.id == "mala" {
                        self.catsBreeds.remove(at: index)
                    } else {
                        if breed.id == "ebur" {
                            self.catsBreeds[index].referenceImageId = "d8sbdRtLJ"
                        } else {
                            switch breed.referenceImageId {
                                case "O3btzLlsO":
                                    self.catsBreeds[index].referenceImageId = "J2PmlIizw"
                                case "4RzEwvyzz":
                                    self.catsBreeds[index].referenceImageId = "jnqO9lwG2"
                                case "DbwiefiaY":
                                    self.catsBreeds[index].referenceImageId = "xPuWATvp9"
                                default : break
                            }
                        }
                    }
                }
            }
        }
    }
    
}

