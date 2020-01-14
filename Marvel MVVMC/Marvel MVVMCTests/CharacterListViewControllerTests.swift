//
//  CharacterListViewControllerTests.swift
//  Marvel MVVMCTests
//
//  Created by Lewis McGrath on 14/01/2020.
//  Copyright © 2020 Lewis McGrath. All rights reserved.
//

import XCTest

@testable import Marvel_MVVMC

class CharacterListViewControllerTests: XCTestCase {

    var subject: CharacterListViewController!
    var mockCharacterListService: MockCharacterListService!
    
    override func setUp() {
        super.setUp()
        mockCharacterListService = MockCharacterListService()
        subject = CharacterListViewController(characterListService: mockCharacterListService)
        
    }

    override func tearDown() {
        super.tearDown()
        subject = nil
        
    }

    func test_viewIsLoaded_tableViewIsASubView() {
        subject.viewDidLoad()
        let tableView = subject.view.subviews.first { $0 is UITableView }
        XCTAssertNotNil(tableView)
    }
    
    func test_viewIsLoaded_tableViewConfiguredCorrectly() {
        subject.viewDidLoad()
        let tableView = subject.tableview
        XCTAssertTrue(tableView.delegate === subject)
        XCTAssertTrue(tableView.dataSource === subject)
    }
    
    func test_tableViewNumberOfRows_isEqualToTheNumberOfCharacters() {
        subject.listOfCharacters.append(CharacterDetail.mock())
        let numberOfRows = subject.tableView(subject.tableview, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 1)
    }
    
    func test_tableViewCellForRow_configuresCell() {
        let characterDetail = CharacterDetail.mock()
        subject.listOfCharacters.append(characterDetail)
        subject.viewDidLoad()
        let cell = subject.tableView(subject.tableview, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterListTableViewCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.characterLabel.text, characterDetail.name)
    }
    
    
    func test_tableViewCellForRow_populatedWithAnImage() {
        let characterDetail = CharacterDetail.mock()
        subject.listOfCharacters.append(characterDetail)
        subject.viewDidLoad()
        let cell = subject.tableView(subject.tableview, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterListTableViewCell
        XCTAssertTrue(mockCharacterListService.getCharacterImageCalled)
    }
    
    func test_tableViewCellForRow_populatedWithCharacters() {
        subject.viewDidLoad()
        
        XCTAssertTrue(mockCharacterListService.getCharacterDataResponseCalled)
    }
}

final class MockCharacterListService: CharacterListServiceProtocol {
    
    var getCharacterDataResponseCalled: Bool = false
    func getCharacterDataResponse(completion: @escaping (Response?) -> Void) {
        getCharacterDataResponseCalled = true
    }
    
    var getCharacterImageCalled: Bool = false
    func getCharacterImageResponse(from thumbnailImageUrl: String, completion: @escaping (UIImage?) -> Void) {
        getCharacterImageCalled = true
    }
}




extension CharacterDetail {
    static func mock() -> CharacterDetail {
        return CharacterDetail(id: 1,
                               name: "Test",
                               resultDescription: "Result",
                               thumbnail: Thumbnail(path: "path", thumbnailExtension: .jpg))
    }
}
