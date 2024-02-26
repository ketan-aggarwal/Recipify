

import XCTest
@testable import Recipify

final class RecipyDiscoverPresenterTest: XCTestCase {
    
    var presenter: DashBoardPresenter?
    var viewController: DiscoverViewContollerMock?
    
    override func setUpWithError() throws {
        presenter = DashBoardPresenter()
        viewController = DiscoverViewContollerMock()
        presenter?.viewController = viewController
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        viewController = nil
    }
    
    func testPresentFetchedData() throws {
        // Given
        let recipeCategories: [[RecipeElement]] = [
            [RecipeElement(id: 1, title: "Recipe 1", image: "image1", readyInMinutes: 30, healthScore: 80, veryPopular: false, veryHealthy: false)],
            [RecipeElement(id: 2, title: "Recipe 2", image: "image2", readyInMinutes: 25, healthScore: 90 ,veryPopular: false, veryHealthy: false)],
        ]
        
        
        presenter?.presentFetchedData(recipeCategories: recipeCategories)
        
        // Then
        XCTAssertNotNil(viewController?.receivedViewModel)
        XCTAssertEqual(viewController?.receivedViewModel?.dashboardTableItems.count, recipeCategories.count + 1) // Plus one for cuisine items
    }
    
    func testPresentFilteredDataWithNilRecipeCategories() throws {
        
        let nilRecipeCategories: [[RecipeElement]]? = nil
        presenter?.presentFetchedData( recipeCategories: nilRecipeCategories ?? [])
        XCTAssertNil(viewController?.receivedViewModel)
    }
    
    
    
    func testCuisineItemsAppended() throws {
        // Given
        let presenter = DashBoardPresenter()
        let mockViewController = DiscoverViewContollerMock()
        presenter.viewController = mockViewController
        
        let recipeCategories: [[RecipeElement]] = [
            [RecipeElement(id: 1, title: "Recipe 1", image: "image1", readyInMinutes: 30, healthScore: 80, veryPopular: false, veryHealthy: false)],
            [RecipeElement(id: 2, title: "Recipe 2", image: "image2", readyInMinutes: 25, healthScore: 90 ,veryPopular: false, veryHealthy: false)],
        ]
        
        // When
        presenter.presentFetchedData(recipeCategories: recipeCategories)
        
        // Then
        XCTAssertNotNil(mockViewController.receivedViewModel)
        XCTAssertEqual(mockViewController.receivedViewModel?.dashboardTableItems.count, recipeCategories.count + 1) // Plus one for cuisine items
        XCTAssertTrue(mockViewController.receivedViewModel?.dashboardTableItems.contains(where: { $0.dashboardItems.contains(where: { $0.itemType == .cuisine }) }) ?? false)
    }
    
}

class DiscoverViewContollerMock: DiscoverViewContoller {
    private(set) var receivedViewModel: DashBoardScreenViewModel?
    
    override func displayDashBoardData(viewModel: DashBoardScreenViewModel) {
        receivedViewModel = viewModel
    }
}
