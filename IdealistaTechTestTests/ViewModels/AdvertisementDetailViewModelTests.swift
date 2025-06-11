import XCTest
@testable import IdealistaTechTest

final class AdvertisementDetailViewModelTests: XCTestCase {
    var mockRepository: MockDataRepository!
    var viewModel: AdvertisementDetailViewModel!

    override func setUp() {
        super.setUp()
        mockRepository = MockDataRepository()
    }

    override func tearDown() {
        mockRepository = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testGetAdvertisementDetail_Success() async {
        // Arrange
        let expectedModel = AdvertisementDetailModel.mock()
        mockRepository.advertisementDetailResult = .success(expectedModel)
        viewModel = AdvertisementDetailViewModel(repository: mockRepository, advertisementId: 123)

        // Act
        await viewModel.getAdvertisementDetail()

        // Assert
        XCTAssertEqual(viewModel.advertisement, expectedModel)
    }
    
    func testGetAdvertisementDetail_Failure() async {
        // Arrange
        mockRepository.advertisementDetailResult = .failure(NSError(domain: "Test", code: 1, userInfo: nil))
        viewModel = AdvertisementDetailViewModel(repository: mockRepository, advertisementId: 123)

        // Act
        await viewModel.getAdvertisementDetail()

        // Assert
        XCTAssertNil(viewModel.advertisement)
    }

}
