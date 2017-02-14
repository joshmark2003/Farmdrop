//
//  Constants.swift
//  MealPlanning
//
//  Created by Nadim Alam on 08/02/2016.
//  Copyright © 2016 Nadim Alam. All rights reserved.
//


struct Constants {
    
    struct URL {
        static let BaseUrl                  = "https://fd-v5-api-release.herokuapp.com/2/producers"
    }
    
//    static let DevCertificate                 = "api.dev.jsplanner.co.uk"
//    
//    static let ProdCertificate                = "api.prd.jsplanner.co.uk"
//    
//    static let util = Util()
//    
//    static let shopWithGOL = ShopWithGOL()
//
//    static let dataManager = DataManager()
//    
//    static let suggestedProductManager = SuggestedProductManager()
//
//    static let shoppingListManager = ShoppingListManager()
//
//    static let categoryManager = CategoryManager()
//    
//    static let inventoryManager = InventoryProductManager()
//    
//    static let recipeManager = RecipeManager()
//
//    static let ingredientManager = IngredientManager()
//        
//    static let mealManager = MealManager()
//    
//    static let mealProductManager = MealProductManager()
//    
//    static let userManager = UserManager()
    
    static let httpRequestManager = NetworkRequest()
    
    static let producerManager = ProducerManager()
}
