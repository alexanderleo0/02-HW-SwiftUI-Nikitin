    //
    //  CharactersViewModel.swift
    //  02-HW-SwiftUI-Nikitin
    //
    //  Created by Александр Никитин on 15.03.2023.
    //

import Foundation
import Networking

    // MARK: - ViewModel
final class HeroesViewModel: ObservableObject {
    @Published private(set) var heroesDict : [HeroesID : [Characters]] = [.rick: [],
                                                                          .alien: [],
                                                                          .humans: [],
                                                                          .jerry: [],
                                                                          .beth: [],
                                                                          .summer: [],
                                                                          .morty: []]
    
    var heroes : [HeroesID : Hero] = [.rick : Hero(id: .rick, name: "Rick", page: 0),
                                      .morty : Hero(id: .morty, name: "Morty", page: 0),
                                      .summer : Hero(id: .summer, name: "Summer", page: 0),
                                      .beth :  Hero(id: .beth, name: "Beth", page: 0),
                                      .jerry : Hero(id: .jerry, name: "Jerry", page: 0),
                                      .alien : Hero(id: .alien,species: "Alien", page: 0),
                                      .humans : Hero(id: .humans, species: "Human", page: 0)]
    
    var heroesIDs: [HeroesID] = [.rick, .morty, .summer, .beth, .jerry, .humans, .alien]
    
    init() {
        fetchData(heroID: .rick)
    }
    var datafetchIsStarting = false
    func fetchData (heroID : HeroesID) {
        guard let hero = heroes[heroID] else { return }
        
            //Если все страничуи прочитаны, то больше не идем запрашиваться
        guard let _ = hero.page else { return }
        
        if datafetchIsStarting == true { return }
        
        //Ставим ограничитель на много запросов
        datafetchIsStarting = true
        
        RMCharactersAPI.characterGet(page: hero.page, name: hero.name, species: hero.species) { data, error in
            
            if let error = error {
                //не хочу обрабаотывать ошибки
                return
            }
            if let data = data {
                
                if let next  = data.info.next,
                   let components = URLComponents(string: next),
                   let items = components.queryItems {
                   
                    for item in items {
                        if item.name == "page" {
                            self.heroes[hero.id]?.page = Int(item.value ?? "0")
                            break
                        }
                    }
                } else {
                    //Ставим nil когда прочитали все странички
                    self.heroes[hero.id]?.page = nil
                }
                self.heroesDict[hero.id]?.append(contentsOf: data.results)
            }
            //Сбрасываем ограничитель
            self.datafetchIsStarting = false
        }
    }
}

enum HeroesID: String, Hashable {
    case rick = "Rick"
    case morty = "Morty"
    case summer = "Summer"
    case beth = "Beth"
    case jerry = "Jerry"
    case humans = "Human"
    case alien = "Alien"
}

struct Hero: Hashable, Identifiable, Comparable {
    static func < (lhs: Hero, rhs: Hero) -> Bool {
        return true
    }
    
    
    let id : HeroesID
    let name: String?
    let species: String?
    var page: Int?
    
    internal init(id: HeroesID, name: String? = nil, species: String? = nil, page: Int? = nil) {
        self.id = id
        self.name = name
        self.species = species
        self.page = page
        
    }
}
