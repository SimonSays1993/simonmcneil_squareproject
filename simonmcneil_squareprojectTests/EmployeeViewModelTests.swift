import XCTest
@testable import simonmcneil_squareproject

final class EmployeeViewModelTests: XCTestCase {

    var sut: EmployeeViewModel!
    
    func testsCreateEmployeeSectionNonEmpty() async {
        sut = EmployeeViewModel(apiService: ApiPreviewClient(), resource: .init(endPoint: MockApiEndPoints.employeeDetails))
        await sut.fetchEmployees()
        XCTAssertFalse(sut.employeeSections.isEmpty)
    }
    
    func testForContractorEmployeeSectionTitle() async {
        sut = EmployeeViewModel(apiService: ApiPreviewClient(), resource: .init(endPoint: MockApiEndPoints.employeeDetails))
        await sut.fetchEmployees()
        
        let employeeContractorSection = sut.employeeSections[2]
        XCTAssertEqual(employeeContractorSection.key, 2)
        XCTAssertEqual(employeeContractorSection.value[0].employeePosition, "Contractor")
    }
    
    func testForFullTimeEmployeeSectionTitle() async {
        sut = EmployeeViewModel(apiService: ApiPreviewClient(), resource: .init(endPoint: MockApiEndPoints.employeeDetails))
        await sut.fetchEmployees()
        
        let employeeContractorSection = sut.employeeSections[0]
        XCTAssertEqual(employeeContractorSection.key, 0)
        XCTAssertEqual(employeeContractorSection.value[0].employeePosition, "Full Time")
    }
    
    func testForPartTimeEmployeeSectionTitle() async {
        sut = EmployeeViewModel(apiService: ApiPreviewClient(), resource: .init(endPoint: MockApiEndPoints.employeeDetails))
        await sut.fetchEmployees()
        
        let employeeContractorSection = sut.employeeSections[1]
        XCTAssertEqual(employeeContractorSection.key, 1)
        XCTAssertEqual(employeeContractorSection.value[0].employeePosition, "Part Time")
    }
    
    func testCreateImageModel() {
        sut = EmployeeViewModel(apiService: ApiPreviewClient(), resource: .init(endPoint: MockApiEndPoints.employeeDetails))
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
    
    func testSectionOrder() async {
        sut = EmployeeViewModel(apiService: ApiPreviewClient(), resource: .init(endPoint: MockApiEndPoints.employeeDetails))
        await sut.fetchEmployees()
        
        let sectionOne = sut.employeeSections[0].key
        let sectionTwo = sut.employeeSections[1].key
        let sectionThree = sut.employeeSections[2].key
        
        XCTAssertTrue((sectionOne < sectionTwo) && (sectionOne < sectionThree))
        XCTAssertTrue((sectionTwo > sectionOne) && (sectionTwo < sectionThree))
    }
}
