import XCTest
@testable import simonmcneil_squareproject

final class ApiClientTests: XCTestCase {
    var sut: EmployeeViewModel!
    var client: ApiPreviewClient!
    
    override func tearDown() {
        sut = nil
        client = nil
    }

    func testFetchContent() async throws {
        let client = ApiPreviewClient()
        sut = EmployeeViewModel(apiService: client, resource: .init(endPoint: MockApiEndPoints.employeeDetails))
        await sut.fetchEmployees()
        XCTAssertTrue(client.fetchSuccessful)
    }
    
    func testDecodingError() async throws {
        let client = ApiPreviewClient()
        sut = EmployeeViewModel(apiService: client, resource: .init(endPoint: MockApiEndPoints.decodingError))
        await sut.fetchEmployees()
        XCTAssertEqual(sut.errorMessage, "Failed to Decode Content")
        XCTAssertFalse(client.fetchSuccessful)
    }
}
