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
    @EnvironmentObject var heroesVM : HeroesViewModel
    
    @State var selectedID: HeroesID = .rick
    
    var body: some View {
        NavStack(content: {
            VStack {
                
                HorizontalView(selectedID: $selectedID)
                
                
                VericalView(selectedID: $selectedID)
                
                
                
                
            }
        })
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(HeroesViewModel())
        
    }
}

struct HorizontalView: View {
    @EnvironmentObject var heroesVM : HeroesViewModel
    @Binding var selectedID: HeroesID
    
    var body: some View {
        ScrollViewReader{ value in
            ScrollView(.horizontal, showsIndicators: false) {
//        List{
                HStack(spacing: 3){
                    ForEach(heroesVM.heroesIDs, id: \.self) { id in
                        
                        SimpleCard(
                            image: Image(heroesVM.heroes[id]!.name ?? heroesVM.heroes[id]!.species!),
                            text: Text(heroesVM.heroes[id]!.name ?? heroesVM.heroes[id]!.species!))
                        .scaleEffect(id == selectedID ? 1.3 : 1)
                        .padding(id == selectedID ? 40 : 2)
                        .shadow(radius: 5)
                        .onTapGesture {
                            withAnimation {
                                selectedID = id
                                
//                                value.scrollTo(id, anchor: .center)
                                if heroesVM.heroesDict[id]!.count == 0 {
                                    heroesVM.fetchData(heroID: id)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct VericalView: View {
    
    @EnvironmentObject var heroesVM : HeroesViewModel
    @Binding var selectedID: HeroesID
        //    @State var selectedHero: Characters
    
    var body: some View {
        ScrollViewReader{ value in
            ScrollView {
//        List{
                LazyVGrid(columns: Array(repeating: .init(), count: 3), spacing: 6) {
                    Group{}
                        .id("SCROLL_TO_TOP")
                    
                    ForEach(heroesVM.heroesDict[selectedID]!, id: \.self) { hero in
                        NavLink(destination: DetailScreen(character: hero)) {
                            if let url = URL(string: hero.image ?? ""){
                                ZStack(alignment: .bottom) {
                                    KFImage(url)
                                        .cacheMemoryOnly()
                                        .resizable()
                                        .placeholder {ProgressView()}
                                        .aspectRatio(contentMode: .fill)
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                                        .clipped()
                                        .onAppear()
                                    
                                }
                            }
                        }
                        
                    }
                    if heroesVM.heroes[selectedID]?.page != nil {
                        
                        ProgressView()
                            .scaleEffect(2)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                            .onAppear{
                                heroesVM.fetchData(heroID: selectedID)
                            }
                    }
                }
//                .onChange(of: selectedID, perform: { _ in
//                    withAnimation {
//                        value.scrollTo("SCROLL_TO_TOP", anchor: .center)
//                    }
//
//                })
                .listStyle(.plain)
            }
            
        }
        .padding(.horizontal)
    }
    
        
}

