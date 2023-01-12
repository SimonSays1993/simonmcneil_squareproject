import XCTest
@testable import simonmcneil_squareproject

final class ApiClientTests: XCTestCase {
    var sut: EmployeeViewModel!
    var client: ApiPreviewClient!
    
    override func tearDown() {
        sut = nil
        client = nil
    }

    func testFetchContent() async {
        let client = ApiPreviewClient()
        sut = EmployeeViewModel(apiService: client, resource: .init(endPoint: MockApiEndPoints.employeeDetails))
        await sut.fetchEmployees()
        XCTAssertTrue(client.fetchSuccessful)
    }
    
    func testDecodingError() async {
        let client = ApiPreviewClient()
        sut = EmployeeViewModel(apiService: client, resource: .init(endPoint: MockApiEndPoints.decodingError))
        await sut.fetchEmployees()
        XCTAssertEqual(sut.errorMessage, "Failed to Decode Content")
        XCTAssertFalse(client.fetchSuccessful)
    }
    
    func testEmptyResponseError() async {
        sut = EmployeeViewModel(apiService: ApiPreviewClient(), resource: .init(endPoint: MockApiEndPoints.employeeEmpty))
        await sut.fetchEmployees()
        XCTAssertTrue(sut.employeeSections.isEmpty)
        XCTAssertEqual(sut.errorMessage, "")
    }
}
