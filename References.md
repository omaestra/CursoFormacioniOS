# Documentación oficial
## Apple developer docs
https://developer.apple.com/documentation/

## Swift
https://swift.org

# ¿Cómo leer la documentación oficial de Apple?
https://www.hackingwithswift.com/articles/167/how-to-read-apples-developer-documentation
https://learnappmaking.com/apple-developer-documentation-how-to/

# Best practices

## Swift API Design Guidelines
[Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/#general-conventions)

## Swift Best Practices Medium article
https://medium.com/@spmandrus/basics-swift-best-practices-175c21631aad

## Google Swift Style Guide
https://google.github.io/swift/

## Raywenderlich Swift Style Guide
https://github.com/raywenderlich/swift-style-guide

## 

# Libros:
## 1) “App Development with Swift” by Apple Education ###
https://books.apple.com/es/book/app-development-with-swift/id1465002990?l=en

# Fuentes recomendadas
1) Apple
2) Stack Overflow
3) Ray Wenderlich
4) Medium

# Cheat sheet
https://koenig-media.raywenderlich.com/uploads/2014/06/RW-Swift-Cheatsheet-0_8.pdf

# Documentation comments
[Apple Markup Formatting Reference](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/index.html)

[NSHipster -- Swift documentation comment](https://nshipster.com/swift-documentation)

# JSON Guide

[Ultimate Guide to JSON Parsing with Swift 4](https://benscheirman.com/2017/06/swift-json/)

# Herramientas para desarrollo

- iOS development: 
  - Xcode
  - Interface Builder
  - Swift
- Diseño gráfico:
  - Sketch
  - Invision
  - PaintCode
- Gestor de paquetes:
  - CocoaPods (Antes de Swift Package Manager).
- Librerías:
  - Alamofire
  - Moya
  - Siesta
  - MBProgressHUD
  - Charts
- Storage y Bases de datos:
  - Firebase
  - Realm
  - Core Data
- Integración contínua:
  - Fastlane
  
  
  
`  var meals: [Meal] = {
        var breakfast = Meal(name: "Breakfast", food: [])
        var lunch = Meal(name: "Lunch", food: [])
        var dinner = Meal(name: "Dinner", food: [])
        
        let sandwich = Food(name: "Grilled Steelhead Trout Sandwich", description: "Pacific steelhead trout* with lettuce, tomato, and red onion.")
        let soup = Food(name: "Chicken Noodle Soup", description: "Delicious chicken simmered alongside yellow onions, carrots, celery, and bay leaves, chicken stock.")
        breakfast.food = [sandwich, soup]
        
        let pizza = Food(name: "Margherita Pizza", description: "Tomato sauce, fresh mozzarella, basil, and extra-virgin olive oil.")
        let spaghetti = Food(name: "Spaghetti and Meatballs", description: "Seasoned meatballs on top of freshly-made spaghetti. Served with a robust tomato sauce.")
        lunch.food = [pizza, spaghetti]
        
        let salad = Food(name: "Italian Salad", description: "Garlic, red onions, tomatoes, mushrooms, and olives on top of romaine lettuce.")
        let linguini = Food(name: "Pesto Linguini", description: "Stewed sliced beef with yellow onions and garlic in a vinegar-soy sauce. Served with steamed jasmine rice and sautéed vegetables.")
        dinner.food = [salad, linguini]

        return [breakfast, lunch, dinner]
    }()
`
