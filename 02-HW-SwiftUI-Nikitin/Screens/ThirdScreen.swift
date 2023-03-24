//
//  ThirdScreen.swift
//  02-HW-SwiftUI-Nikitin
//
//  Created by Александр Никитин on 23.03.2023.
//

import SwiftUI
import Networking

struct ThirdScreen: View {
    let deal : Deals

    var body: some View {
        VStack{
            Text("Metacriticks")
            Stars(raiting: deal.metacriticScore)
            Text("Steam")
            Stars(raiting: deal.steamRatingPercent)
        }
    }
}

struct ThirdScreen_Previews: PreviewProvider {
    static var previews: some View {
        ThirdScreen(deal: Deals(internalName: "InternalName", title: "SomeTitle", dealID: "123", storeID: "123", gameID: "123", salePrice: "101.12", normalPrice: "299.90", isOnSale: "1", savings: "10%", metacriticScore: "79",steamRatingPercent: "84",  releaseDate: 123123123123, lastChange: 123123123123, dealRating: "100", thumb: "https://apptractor.ru/wp-content/uploads/2016/08/cropped-logo-2-92x92.jpg"))
    }
}

struct Stars: View {
    let raiting : String?
    
    @State var starsIsClicked = false
    
    var body: some View {
        HStack{
            ForEach(1..<5+1) { number in
                Image(systemName: "star.fill")
                    .foregroundColor((Int(raiting ?? "0") ?? 0)/20 >= number ? .yellow : .gray )
                    .font(.largeTitle)
                    .offset(y: starsIsClicked ? CGFloat.random(in: -700 ... 700) : 0)
                    .rotationEffect(starsIsClicked ? Angle.degrees(Double.random(in: -180...180)) : Angle(degrees: 0))
                    .animation(.linear(duration: 3), value: starsIsClicked)
                    .onTapGesture {
                        starsIsClicked.toggle()
                    }
            }
        }
        
        
        
        .padding(.bottom, 50)
    }
}
