import Foundation

protocol DataAccess<Request, Response> {
    associatedtype Request
    associatedtype Response
    
    func fetch(request: Request) async throws -> Response
}
