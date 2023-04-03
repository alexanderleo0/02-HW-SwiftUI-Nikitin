//
//  ServiceLocator.swift
//  02-HW-SwiftUI-Nikitin
//
//  Created by Александр Никитин on 01.04.2023.
//

//import Foundation
//
//
//class ServiceLocator {
////    static let shared = ServiceLocator()
//    private var containerService = [String: AnyObject]()
//
//    func addService<T:AnyObject>(service: T) {
//        let key = "\(T.self)"
//        debugPrint(key)
//        if containerService[key] == nil {
//            containerService[key] = service
//        }
//    }
//
//    func getService<T:AnyObject>(type: T.Type) -> T? {
//        let key = "\(T.self)"
//        return containerService[key] as? T
//    }
//}

import Foundation

class ServiceLocator : NSObject {
    private var containerServices = [String: AnyObject]()
    
    func addService<T:AnyObject>(service: T) {
        let key = "\(T.self)"
        if containerServices[key] == nil {
            containerServices[key] = service
        }
    }
    
    func getService<T:AnyObject>(type: T.Type)->T? {
        let key = "\(T.self)"
        return containerServices[key] as? T
    }
}
