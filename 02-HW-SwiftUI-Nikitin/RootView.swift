    //
    //  RootView.swift
    //  02-HW-SwiftUI-Nikitin
    //
    //  Created by Александр Никитин on 15.03.2023.
    //

import SwiftUI
import Kingfisher
import ALNUI
import Networking


struct RootView: View {
    
    @EnvironmentObject var catsVM: CatsViewModel
    @EnvironmentObject var breedsVM: BreedsViewModel
    
    @State var selectedBreed: Breeds?
    
    var body: some View {
        VStack {
            ScrollViewReader{ value in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 3){
                        ForEach(breedsVM.catsBreeds) { breed in
                            if let id = breed.referenceImageId, let name = breed.name {
                                let url = "https://cdn2.thecatapi.com/images/" + id + ".jpg"
                                SimpleCard(image: KFImage(URL(string: url)), text: Text(name))
                                    .scaleEffect(breed == selectedBreed ? 0.8 : 1)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedBreed = breed
                                            value.scrollTo(breed.id, anchor: .center)
                                        }
                                        
                                        if let id = breed.id {
                                            catsVM.searchId = id
                                        }
                                    }
                            }
                        }
                    }
                }
                
            }
            
            .tabViewStyle(.page)
            .frame(height: 200)
            .padding()
            
            List(catsVM.cats) { cat in
                HStack{
                    if let url = cat.url{
                        KFImage(URL(string: url))
                            .resizable()
                            .scaledToFit()
                            
                    }
                }
            }
            .listStyle(.plain)
           
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(CatsViewModel())
            .environmentObject(BreedsViewModel())
    }
}
