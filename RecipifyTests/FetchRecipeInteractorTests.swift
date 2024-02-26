//
//  FetchRecipeInteractorTests.swift
//  RecipifyTests
//
//  Created by Ketan Aggarwal on 26/02/24.
//

import XCTest
@testable import Recipify

final class FetchRecipeInteractorTests: XCTestCase {

    var interactor: FetchRecipeInteractor!
       var mockWorker: MockFetchRecipeWorker!
       var mockPresenter: MockFetchRecipePresenter!

       override func setUpWithError() throws {
           interactor = FetchRecipeInteractor()
           mockWorker = MockFetchRecipeWorker()
           mockPresenter = MockFetchRecipePresenter()
           interactor.worker = mockWorker
           interactor.presenter = mockPresenter
       }

       override func tearDownWithError() throws {
           interactor = nil
           mockWorker = nil
           mockPresenter = nil
       }

       func testEmptyViewModelWhenNoResults() {
           // Given
           XCTAssertNotNil(interactor)
           XCTAssertNotNil(mockWorker)
           XCTAssertNotNil(mockPresenter)
           mockWorker.shouldReturnEmptyData = true // Set the flag to true to simulate no data from the API

           // When
           interactor.fetchRecipes(inputString: "invalid_search_text")

           // Then
           XCTAssertTrue(mockPresenter.presentRecipeCalled)
           XCTAssertNotNil(interactor.searchRecipes)
           XCTAssertTrue(interactor.searchRecipes.isEmpty)
       }

}
class MockFetchRecipeWorker: FetchRecipeWorker {
    var shouldReturnEmptyData = false

    override func fetchRecipe(inputString: String, completion: @escaping ([RecipeElement]?) -> Void) {
        if shouldReturnEmptyData {
            completion([]) // Simulate no data from the API
        } else {
            // Provide mock data if needed for other test cases
        }
    }
}

class MockFetchRecipePresenter: FetchRecipePresenter {
    var presentRecipeCalled = false

    override func presentRecipe(searchRecipes: [RecipeElement]) {
        presentRecipeCalled = true
    }
}
