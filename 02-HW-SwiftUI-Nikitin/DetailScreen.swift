//
//  DetailScreen.swift
//  02-HW-SwiftUI-Nikitin
//
//  Created by Александр Никитин on 18.03.2023.
//

import SwiftUI
import Kingfisher
import Networking
import NavStack

struct DetailScreen: View {
    let character : Characters?
    
    var body: some View {
        VStack{
            if let url = URL(string: character?.image ?? "") {
                KFImage(url)
            }
            Text((character?.name ?? character?.species) ?? "No Name")
            Text(character?.species ?? "")
            Text(character?.gender ?? "")
            Text(character?.location?.name ?? "")
            NavLink(destination: Text("sdasdad")) {
                Text("EPISODES")
            }
        }
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(character: nil)
            
            
    }
}
