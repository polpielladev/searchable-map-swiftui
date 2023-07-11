//
//  File.swift
//  
//
//  Created by Pol Piella Abadia on 04/07/2023.
//

import Foundation

enum SearchLocationServiceFactory {
    static func make() -> SearchLocationService {
        let dataAccess = MapKitDataAccess()
        return DefaultSearchLocationService(dataAccess: dataAccess)
    }
}
