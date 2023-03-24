//
//  _2_HW_SwiftUI_NikitinApp.swift
//  02-HW-SwiftUI-Nikitin
//
//  Created by Александр Никитин on 15.03.2023.
//

import SwiftUI

@main
struct _2_HW_SwiftUI_NikitinApp: App {

    var body: some Scene {
        WindowGroup {
            RootView()
                
                .environmentObject(CSViewModel())
        }
    }
}
