//
//  Array+IsLast.swift
//  PagingNwtworkExample
//
//  Created by Nikolai Baklanov on 20.03.2023.
//

import Foundation

extension RandomAccessCollection where Self.Element: Identifiable {
    func isLastItem<Item: Identifiable>(_ item: Item) -> Bool {
        guard isEmpty == false else { return false }
        guard let itemIndex = firstIndex(where: {
            return AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }
        
        let distance = self.distance(from: itemIndex, to: endIndex)

        return distance == 1
    }
}
