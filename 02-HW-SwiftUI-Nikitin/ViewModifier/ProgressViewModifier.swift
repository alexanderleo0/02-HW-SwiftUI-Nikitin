//
//  ProgressViewModifier.swift
//  PagingNwtworkExample
//
//  Created by Nikolai Baklanov on 21.03.2023.
//

import Foundation
import SwiftUI
import ALNUI

struct ProgressViewModifier: ViewModifier {
    let isLoading: Bool

    func body(content: Content) -> some View {
        if !isLoading {
            content
        } else {
            VStack {
                content
                HStack {
                    Spacer()
                    SpinnerLoadingView()
                    Spacer()
                }
            }
        }
    }
}
