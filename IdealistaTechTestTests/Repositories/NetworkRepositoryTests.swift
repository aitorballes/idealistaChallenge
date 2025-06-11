import XCTest
@testable import IdealistaTechTest 

final class NetworkRepositoryTests: XCTestCase {
    var network: NetworkRepository!
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockNetworkInteractor.self]
        let session = URLSession(configuration: config)
        network = NetworkRepository(session: session)
    }
    
    override func tearDownWithError() throws {
        network = nil
    }
    
    func testGetAdvertisements() async throws {
        // Act
        let ads = try await network.getAdvertisements()
        // Assert
        XCTAssertEqual(ads.count, 4, "Must return 4 advertisements")
    }
    
    func testGetAdvertisementDetail() async throws {
        // Act
        let detail = try await network.getAdvertisementDetail(for: 1)
        // Assert
        XCTAssertEqual(detail.id, 1, "The advertisement detail must have ID 1")
    }
}
