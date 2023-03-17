//
//  _2_HW_SwiftUI_NikitinApp.swift
//  02-HW-SwiftUI-Nikitin
//
//  Created by Александр Никитин on 15.03.2023.
//

import SwiftUI

@main
struct _2_HW_SwiftUI_NikitinApp: App {
    
    @StateObject var catsVM: CatsViewModel = CatsViewModel()
    @StateObject var breedsVM: BreedsViewModel = BreedsViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(catsVM)
                .environmentObject(breedsVM)
        }
    }
}
