import MapKit

class MapKitDataAccess: DataAccess {
    func fetch(request: MapSearchRequest) async throws -> [MKMapItem] {
        let mapKitRequest = MKLocalSearch.Request()
        mapKitRequest.naturalLanguageQuery = request.query
        mapKitRequest.pointOfInterestFilter = .init(including: [.restaurant, .bakery, .brewery, .cafe, .winery, .foodMarket, .hotel])
        mapKitRequest.resultTypes = .pointOfInterest
        let search = MKLocalSearch(request: mapKitRequest)
        
        let response = try await search.start()
        
        return response.mapItems
    }
}
