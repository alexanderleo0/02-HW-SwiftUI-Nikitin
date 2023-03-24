//
//  View+Extension.swift
//  PagingNwtworkExample
//
//  Created by Nikolai Baklanov on 21.03.2023.
//

import Foundation
import SwiftUI

extension View {
    func showActivityIdicator(_ value: Bool) -> some View {
        modifier(ProgressViewModifier(isLoading: value))
    }
}
