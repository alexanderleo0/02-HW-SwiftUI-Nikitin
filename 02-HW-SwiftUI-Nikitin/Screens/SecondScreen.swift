//
//  SecondScreen.swift
//  02-HW-SwiftUI-Nikitin
//
//  Created by Александр Никитин on 23.03.2023.
//

import SwiftUI
import Networking
import Kingfisher
import NavStack

struct SecondScreen: View {
    @State var isClicked = false
    let deal : Deals
    var body: some View {
        VStack{
            Group {
                if let url = URL(string: deal.thumb ?? "") {
                    KFImage(url)
                } else {
                    Image(systemName: "photo")
                        .font(.system(size: 100))
                    
                }
                
            }
         
            .rotation3DEffect(isClicked ? Angle(degrees: 360) : Angle(degrees: 0), axis: (x: 50, y: 50, z: 0) )
            .scaleEffect(isClicked ? 1.3 : 1, anchor: .bottom)
                .onTapGesture {
                    withAnimation {
                        isClicked.toggle()
                    }
                }

                Text(deal.title)
                .font(.system(size: 35, design: .rounded))
            Divider()
            HStack{
                Text("Price")
                    .font(.headline)
                PriceWithDiscount(deal: deal)
            }
            
                ZStack{
                    
                    Button {
                        
                    } label: {
                        NavLink(destination: ThirdScreen(deal: deal)) {
                        ZStack{
                            LinearGradient(colors: [.purple,.red,.orange], startPoint: .trailing, endPoint: .leading)
                                .cornerRadius(30)
                                .frame(height: 40)
                                .padding()
                            Text("Оценка критиков")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            
        }
        .padding()
    }
}

struct SecondScreen_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreen(deal: Deals(internalName: "InternalName", title: "SomeTitle", dealID: "123", storeID: "123", gameID: "123", salePrice: "101.12", normalPrice: "299.90", isOnSale: "1", savings: "10%", releaseDate: 123123123123, lastChange: 123123123123, dealRating: "100", thumb: "https://apptractor.ru/wp-content/uploads/2016/08/cropped-logo-2-92x92.jpg"))
}
}
