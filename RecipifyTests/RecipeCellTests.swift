
import XCTest
@testable import Recipify

final class RecipeCellTests: XCTestCase {

    var cell: RecipeCell!

        override func setUpWithError() throws {
            // Load the RecipeCell from the nib
            let nib = Bundle.main.loadNibNamed("RecipeCell", owner: nil, options: nil)
            cell = nib?.first as? RecipeCell
        }

        override func tearDownWithError() throws {
            cell = nil
        }

        func testConfigure() {
            // Given
            XCTAssertNotNil(cell)
            let recipeItem = CollectionRecipeViewItem(id: 1, title: "Test Recipe", image: "test_image", readyInMinutes: 30, healthScore: 80)

            // When
            cell.configure(withRecipeItem: recipeItem)

            // Then
            XCTAssertEqual(cell.titleLabel.text, "Test Recipe")
            XCTAssertEqual(cell.prepTime.text, "Prep Time: 30 mins")
            XCTAssertEqual(cell.rating.text, "Rating: 80")
           
        }
    
//    func testSaveButtonTapped() {
//           // Given
//           XCTAssertNotNil(cell)
//           let recipeItem = CollectionRecipeViewItem(id: 1, title: "Test Recipe", image: "test_image", readyInMinutes: 30, healthScore: 80)
//           cell.configure(withRecipeItem: recipeItem)
//
//           // When
//           cell.savedButtonTapped()
//
//           // Then
//           XCTAssertTrue(cell.isSaved)
//           XCTAssertTrue(cell.isRecipeSavedInCoreData(recipeItem: recipeItem))
//
//           // When tapped again
//           cell.savedButtonTapped()
//
//           // Then
//
//           XCTAssertFalse(cell.isRecipeSavedInCoreData(recipeItem: recipeItem))
//       }

}
