import XCTest
@testable import IdealistaTechTest

final class AdvertisementListViewModelTests: XCTestCase {
    var mockRepository: MockDataRepository!
    var mockPersistenceRepository: MockPersistenceRepository!
    var viewModel: AdvertisementListViewModel!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockDataRepository()
        mockPersistenceRepository = MockPersistenceRepository()
    }
    
    override func tearDown() {
        mockRepository = nil
        mockPersistenceRepository = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testGetAdvertisements_Success() async {
        // Arrange
        let expectedAdvertisements = AdvertisementModel.mockList()
        mockRepository.advertisementsResult = .success(expectedAdvertisements)
        mockPersistenceRepository.favorites = []
        viewModel = AdvertisementListViewModel(repository: mockRepository, persistenceRepository: mockPersistenceRepository)
        
        // Act
        await viewModel.getAdvertisements()
        
        // Assert
        XCTAssertEqual(viewModel.advertisements, expectedAdvertisements)
    }
    
    func testGetAdvertisements_Success_WithFavorites() async {
        let mockRepo = MockDataRepository()
        let mockPersistence = MockPersistenceRepository()
        let models = AdvertisementModel.mockList()
        mockRepo.advertisementsResult = .success(models)
        mockPersistence.favorites = [FavoriteAdvertisement(id: 2, date: Date())]
        let viewModel = AdvertisementListViewModel(repository: mockRepo, persistenceRepository: mockPersistence)

        await viewModel.getAdvertisements()

        XCTAssertTrue(viewModel.advertisements[1].isFavorite)
        XCTAssertNotNil(viewModel.advertisements[1].favoriteDate)
    }
    
    func testGetAdvertisements_Failure() async {
        let mockRepo = MockDataRepository()
        let mockPersistence = MockPersistenceRepository()
        mockRepo.advertisementsResult = .failure(NSError(domain: "Test", code: 0))
        let viewModel = AdvertisementListViewModel(repository: mockRepo, persistenceRepository: mockPersistence)

        await viewModel.getAdvertisements()

        XCTAssertTrue(viewModel.advertisements.isEmpty)
    }
    
    func testToggleFavorite_AddsFavorite() {
        let mockRepo = MockDataRepository()
        let mockPersistence = MockPersistenceRepository()
        let model = AdvertisementModel.mock()
        let viewModel = AdvertisementListViewModel(repository: mockRepo, persistenceRepository: mockPersistence)
        viewModel.advertisements = [model]

        viewModel.toggleFavorite(advertisement: model)

        XCTAssertTrue(viewModel.advertisements[0].isFavorite)
        XCTAssertEqual(mockPersistence.addFavoriteCalledWith, 1)
    }
    
    func testToggleFavorite_RemovesFavorite() {
        let mockRepo = MockDataRepository()
        let mockPersistence = MockPersistenceRepository()
        var model = AdvertisementModel.mock()
        model.isFavorite = true
        let viewModel = AdvertisementListViewModel(repository: mockRepo, persistenceRepository: mockPersistence)
        viewModel.advertisements = [model]

        viewModel.toggleFavorite(advertisement: model)

        XCTAssertFalse(viewModel.advertisements[0].isFavorite)
        XCTAssertEqual(mockPersistence.removeFavoriteCalledWith, 1)
    }
    
    func testToggleFavorite_AdvertisementNotFound() {
        let mockRepo = MockDataRepository()
        let mockPersistence = MockPersistenceRepository()
        let model = AdvertisementModel.mock()
        let viewModel = AdvertisementListViewModel(repository: mockRepo, persistenceRepository: mockPersistence)
        viewModel.advertisements = []

        viewModel.toggleFavorite(advertisement: model)

        XCTAssertNil(mockPersistence.addFavoriteCalledWith)
        XCTAssertNil(mockPersistence.removeFavoriteCalledWith)
    }





}


        

