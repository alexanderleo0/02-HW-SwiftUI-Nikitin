    //
    //  RootView.swift
    //  02-HW-SwiftUI-Nikitin
    //
    //  Created by Александр Никитин on 15.03.2023.
    //

import SwiftUI
import NavStack
import Kingfisher
import ALNUI
import Networking


struct RootView: View {
    @EnvironmentObject var cheapStoreVM : CSViewModel
    @State var selectedStore: Store?
    
    
    var body: some View {
        if cheapStoreVM.cheapStores.count != 0 {
            NavStack {
                VStack{
                    ZStack(alignment: .top) {
                        
                        VericalView(selectedStore: $selectedStore)
                        
                        HorizontalView(selectedStore: $selectedStore)
                        
                    }
                    if selectedStore == nil {
                        
                        Text ("Select your Store")
                            .font(.largeTitle)
                        
                    }
                    Spacer(minLength: 0)
                    
                }
            }
            
            
        } else {
            SpinnerLoadingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(CSViewModel())
    }
}

struct HorizontalView: View {
    @EnvironmentObject var csVM : CSViewModel
    @Binding var selectedStore: Store?
    
    var body: some View {
        ScrollViewReader{ value in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5){
                    ForEach(csVM.cheapStores, id: \.self){ store in
                        HorizontalCards(selectedStore: $selectedStore, store: store)
                            .onTapGesture {
                                withAnimation {
                                    selectedStore = store
                                    value.scrollTo(store, anchor: .center)
                                    if csVM.dealsFor[store]?.count == 0 {
                                        csVM.fetchGames(forStore: selectedStore!)
                                    }
                                }
                            }
                    }
                }
            }
        }
    }
}

struct HorizontalCards: View {
    
    @Binding var selectedStore: Store?
    let store : Store
    var body: some View {
        if let url = URL(string: "https://www.cheapshark.com\(store.images.logo)") {
            SimpleCard(
                image: KFImage(url),
                text: Text(""))
            .scaleEffect(store == selectedStore ? 1.5 : 1)
            .padding(store == selectedStore ? 20 : 2)
            .shadow(color: .black,
                    radius: store == selectedStore ? 5 : 1)
            
        }
    }
}

struct VericalView: View {
    
    @EnvironmentObject var csVM : CSViewModel
    @Binding var selectedStore: Store?
    
    var body: some View {
        if let selectedStore = selectedStore {
            
            if csVM.dealsFor[selectedStore] == [] {
                SpinnerLoadingView()
                    .frame(height: 300)
            } else {
                ScrollView{
                    ListOfElements(selectedStore: $selectedStore)
                }
            }
        }
    }
}


struct ListOfElements: View {
    
    @EnvironmentObject var csVM : CSViewModel
    @Binding var selectedStore: Store?
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: .init(), count: 1)){
            Spacer()
                .frame(height: 130)
            
            ForEach(csVM.dealsFor[selectedStore!] ?? []) { deal in
                NavLink(destination: SecondScreen(deal: deal)) {
                    VerticalCardsView(deal: deal)
                        .padding(.horizontal)
                        .onAppear {
                            if csVM.dealsFor[selectedStore!]!.isLastItem(deal) {
                                csVM.fetchGames(forStore: selectedStore!)
                                let _ = debugPrint("fetch new deals")
                            }
                        }
                        .showActivityIdicator(csVM.dealsFor[selectedStore!]?.last == deal && !csVM.isFull[selectedStore!]!)
                }
            }
        }
    }
}


