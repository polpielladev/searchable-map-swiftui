import Foundation
import MapKit

protocol SearchLocationService {
    func search(with query: String) async throws -> [SearchResult]
}

struct MapSearchRequest {
    let query: String
}

// Data Access to make requests to...
class DefaultSearchLocationService: SearchLocationService {
    private let dataAccess: any DataAccess<MapSearchRequest, [MKMapItem]>
    
    init(dataAccess: any DataAccess<MapSearchRequest, [MKMapItem]>) {
        self.dataAccess = dataAccess
    }

    
    func search(with query: String) async throws -> [SearchResult] {
        let request = MapSearchRequest(query: query)
        let mapItems = try await dataAccess.fetch(request: request)
        return mapItems.compactMap { item in
            guard let name = item.name, let title = item.placemark.title else {
                return nil
            }
            
            return SearchResult(name: name, title: title, id: .init(), coordinate: item.placemark.coordinate)
        }
    }
}
