    //
    //  CSViewModel.swift
    //  02-HW-SwiftUI-Nikitin
    //
    //  Created by Александр Никитин on 21.03.2023.
    //

import Foundation
import Networking
import SwiftUI


final class CSViewModel: ObservableObject {
    @Published private(set) var cheapStores : [Store] = .init()
    @Published private(set) var dealsFor: [Store:[Deals]] = .init()
    @Published var isFull : [Store:Bool] = .init()
    
    private var pageFor : [Store:Int] = .init()
    
    init () {
        fetchStores()
        
    }
    
    func fetchStores() {
        Task {
            do {
                let response = try await AllStoresAPI.storesGet()
                DispatchQueue.main.async { [weak self] in
                    for store in response {
                        if store.isActive == 1.0 {
                            self?.cheapStores.append(store)
                            self?.dealsFor[store] = []
                            self?.isFull[store] = false
                            self?.pageFor[store] = 1
                        }
                    }
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func fetchGames(forStore store: Store) {
        Task {
            do {
                let response = try await AllDealsAPI.dealsGet(storeID: store.storeID, pageNumber: pageFor[store], pageSize: 10, onSale: "1")
                DispatchQueue.main.async { [weak self] in
                    if response == [] {
                        self?.isFull[store] = true
                        return
                    }
                    for deal in response{
                        if self?.dealsFor[store]!.contains(deal) == false {
                            self?.dealsFor[store]!.append(deal)
                        }
                    }
                    self?.pageFor[store]! += 1
                    
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
            
        }
        
    }
}
