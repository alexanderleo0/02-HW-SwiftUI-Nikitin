    //
    //  CardsView.swift
    //  02-HW-SwiftUI-Nikitin
    //
    //  Created by Александр Никитин on 23.03.2023.
    //

import SwiftUI
import Networking
import Kingfisher
import ALNUI


struct VerticalCardsView: View {
    let deal: Deals
    @State private var yOffset = 0.0
    @State private var timeToHide = true
    @State private var isFav = false
    
    var body: some View {
        ZStack(alignment: .leading){
            LinearGradient(gradient: Gradient(colors: [.purple, .red, .blue]), startPoint: .bottomLeading, endPoint: .trailing)
                .opacity(0.4)
                .frame(maxHeight: 300)
                .cornerRadius(20)
            HStack(alignment: .top){
                if let url = URL(string: deal.thumb ?? "") {
                    KFImage(url)
                        .placeholder({ _ in
                            SpinnerLoadingView()
                        })
                    
                        .resizable()
                        .scaledToFill()
                        .padding(.horizontal)
                        .frame(width: 80, height: 100)
                        .padding(.horizontal, 5)
                        .clipped()
                        .onAppear()
                    
                } else {
                    
                    Image(systemName: "questionmark.circle.fill")
                        .font(.largeTitle)
                        .frame(width: 80, height: 100)
                        .padding(.horizontal, 5)
                    
                }
                VStack(alignment: .leading) {
                    Text(deal.title)
                        .font(.headline)
                    PriceWithDiscount(deal: deal)}
                Spacer()
            }
            .padding()

            
            HStack {
                Spacer()
                Image(systemName: "heart.fill")
                    .font(isFav ? .system(size: 60) : .system(size: 30) )
                    .foregroundColor(isFav ? .red : .gray)
                    //                        .foregroundColor(isFav ? .red : .black)
                
                    .rotationEffect(isFav ? .degrees(20) : .degrees(360))
                    .onTapGesture {
                        withAnimation(.interpolatingSpring(stiffness: 2, damping: 2, initialVelocity: 8)) {
                            isFav.toggle()
                        }
                }
            }.padding()
            
                //            .frame(maxWidth: .infinity)
        }
        
    }
}



struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalCardsView(deal: Deals(internalName: "InternalName", title: "SomeTitle", dealID: "123", storeID: "123", gameID: "123", salePrice: "101.12", normalPrice: "299.90", isOnSale: "1", savings: "10%", releaseDate: 123123123123, lastChange: 123123123123, dealRating: "100", thumb: "https://apptractor.ru/wp-content/uploads/2016/08/cropped-logo-2-92x92.jpg"))
            .previewLayout(.sizeThatFits)
    }
}

struct PriceWithDiscount: View {
    let deal: Deals
    
    var body: some View {
        
        HStack {
            Text(deal.normalPrice+"$")
                .strikethrough()
            Text(deal.salePrice+"$")
                .font(.title)
                .foregroundColor(.red)
            
        }
    }
    
}
