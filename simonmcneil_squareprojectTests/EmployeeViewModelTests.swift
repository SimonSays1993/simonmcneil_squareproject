import XCTest
@testable import simonmcneil_squareproject

final class EmployeeViewModelTests: XCTestCase {

    var sut: EmployeeViewModel!
    
    func testsCreateEmployeeSectionNonEmpty() async throws {
        sut = EmployeeViewModel(apiService: ApiPreviewClient(), resource: .init(endPoint: MockApiEndPoints.employeeDetails))
        await sut.fetchEmployees()
        XCTAssertFalse(sut.employeeSections.isEmpty)
    }
    
    func testForContractorEmployeeSection() async throws {
        sut = EmployeeViewModel(apiService: ApiPreviewClient(), resource: .init(endPoint: MockApiEndPoints.employeeDetails))
        await sut.fetchEmployees()
        
        let employeeContractorSection = sut.employeeSections[0]
        XCTAssertEqual(employeeContractorSection.key, "Contractor")
        XCTAssertEqual(employeeContractorSection.value[0].employeeType, "Contractor")
    }
    
    func testForFullTimeEmployeeSection() async throws {
        sut = EmployeeViewModel(apiService: ApiPreviewClient(), resource: .init(endPoint: MockApiEndPoints.employeeDetails))
        await sut.fetchEmployees()
        
        let employeeContractorSection = sut.employeeSections[1]
        XCTAssertEqual(employeeContractorSection.key, "Full Time")
        XCTAssertEqual(employeeContractorSection.value[0].employeeType, "Full Time")
    }
    
    func testForPartTimeEmployeeSection() async throws {
        sut = EmployeeViewModel(apiService: ApiPreviewClient(), resource: .init(endPoint: MockApiEndPoints.employeeDetails))
        await sut.fetchEmployees()
        
        let employeeContractorSection = sut.employeeSections[2]
        XCTAssertEqual(employeeContractorSection.key, "Part Time")
        XCTAssertEqual(employeeContractorSection.value[0].employeeType, "Part Time")
    }
    
    func testCreateImageModel() {
        sut = EmployeeViewModel(resource: .init(endPoint: MockApiEndPoints.employeeDetails))
        let employeeDetails = EmployeeDetails(uuid: "1",
                                              fullName: "Jack Dorsey",
                                              phoneNumber: "55555555",
                                              emailAddress: "dorsey@square.com",
                                              biography: "I work for you.",
                                              photoUrlSmall: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/b44629e2-47e0-459a-a936-4683f783536b/small.jpg"),
                                              photoUrlLarge: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/b44629e2-47e0-459a-a936-4683f783536b/large.jpg"),
                                              team: "Core",
                                              employeeType: .fullTime)
        
        let imageModel = sut.createImageModel(with: employeeDetails)
        XCTAssertEqual(imageModel.name, "Jack Dorsey")
        XCTAssertEqual(imageModel.team, "Core")
        XCTAssertEqual(imageModel.imageUrl, URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/b44629e2-47e0-459a-a936-4683f783536b/small.jpg"))
        XCTAssertEqual(imageModel.id, "1")
    }
}
