

import XCTest
@testable import Recipify

final class SectionHeaderViewTests: XCTestCase {

    var sectionHeaderView: SectionHeaderView!
        
        override func setUp() {
            super.setUp()
            // Initialize SectionHeaderView from the XIB file
            let nib = UINib(nibName: "SectionHeaderView", bundle: nil)
            sectionHeaderView = nib.instantiate(withOwner: nil, options: nil).first as? SectionHeaderView
        }
        
        override func tearDown() {
            sectionHeaderView = nil
            super.tearDown()
        }
    
    func testSeeAllButtonTapped() {
        // Given
        XCTAssertNotNil(sectionHeaderView)
        let expectedSearchText = "Vegan" // Set the expected search text
        
        // When
        sectionHeaderView.searchText = expectedSearchText
        sectionHeaderView.seeAllButtonTapped(UIButton())
        
        // Then
        XCTAssertTrue(sectionHeaderView.searchText == expectedSearchText, "Search text should be \(expectedSearchText), but it is \(sectionHeaderView.searchText)")
        
        let presentedViewController = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController
        XCTAssertTrue(presentedViewController is FetchRecipeViewController)

        XCTAssertEqual((presentedViewController as? FetchRecipeViewController)?.searchText, expectedSearchText)
    }

        

}
