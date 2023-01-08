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
}
