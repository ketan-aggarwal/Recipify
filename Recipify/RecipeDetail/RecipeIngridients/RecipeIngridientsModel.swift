import Foundation

struct RecipeDetail: Codable {
    let id: Int?
    let title: String?
    var image: String?
    let imageType: String?
    let servings, readyInMinutes: Int?
    let sourceName: String?
    let sourceURL: String?
    let spoonacularSourceURL: String?
    let aggregateLikes, healthScore, spoonacularScore: Double?
    let pricePerServing: Double?
    let cheap: Bool?
    let creditsText: String?
    let dairyFree: Bool?
    let gaps: String?
    let glutenFree: Bool?
    let instructions: String?
    let ketogenic, lowFodmap: Bool?
    let sustainable, vegan, vegetarian, veryHealthy: Bool?
    let veryPopular, whole30: Bool?
    let weightWatcherSmartPoints: Int?
    let dishTypes: [String?]
    let extendedIngredients: [ExtendedIngredient]?
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, imageType, servings, readyInMinutes, sourceName
        case sourceURL = "sourceUrl"
        case spoonacularSourceURL = "spoonacularSourceUrl"
        case aggregateLikes, healthScore, spoonacularScore, pricePerServing, cheap, creditsText, dairyFree, gaps, glutenFree, instructions, ketogenic, lowFodmap, sustainable, vegan, vegetarian, veryHealthy, veryPopular, whole30, weightWatcherSmartPoints, dishTypes, extendedIngredients
    }
}

struct ExtendedIngredient: Codable {
    let aisle: String?
    let amount: Double?
    let id: Int?
    let image: String?
    let meta: [String]?
    let metaInformation: [String]?
    let name, original, originalName, originalString: String?
    let unit: String?
}
