//
//  ListViewModelTests.swift
//  TodoSwiftUITests
//
//  Created by Marcelo Mogrovejo on 14/07/2024.
//

import XCTest
import TodoRepositoryPackage
@testable import TodoSwiftUI

final class ListViewModelTests: XCTestCase {

    func testListViewModel_GetAllTasks_onSuccess() async {
        // Arrange
        let sut = ListViewModel()

        // Act
        do {
            try await sut.getAllTasks()
        } catch {
            // Error
        }

        // Assert
        XCTAssertTrue(sut.tasks.count > 0)
    }

    func testListViewModel_GetAllTasks_onThrows() async throws {
        // Arrange
        let sut = ListViewModel()
        let apiServiceMock = ApiServiceMock()
        sut.apiService = apiServiceMock

        apiServiceMock.isGetAllAsyncSuccess = false

        // Act
        do {
            try await sut.getAllTasks()
        } catch {
            // Assert
            XCTAssertNotNil(error)
            XCTAssertEqual(error, RepositoryError.notFound)
        }

    }

}
