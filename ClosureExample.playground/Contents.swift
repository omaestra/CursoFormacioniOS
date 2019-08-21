import UIKit

class Pokemon: CustomStringConvertible {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    var description: String { return "Pokemon \(name)" }
}

func evolve(seconds: Int, pokemon: Pokemon, closure: @escaping ()->()) -> String {
    let time = DispatchTime.now() + .seconds(seconds)
    
    DispatchQueue.main.asyncAfter(deadline: time) {
        pokemon.name = "Raichu"
        
        closure()
    }
    
    return "\(pokemon.name) evolucionará en \(seconds) segundos."
    
} // evolve

let myPokemon = Pokemon(name: "Pikachu")
print("Antes de evolucionar: \(myPokemon)")

let logMessage = evolve(seconds: 3, pokemon: myPokemon) {
    print("Proceso de Evolución Finalizado: Pikachu ha evolucionado a \(myPokemon.name)")
}

print(logMessage)
print("Después de llamar a la funcion 'evolve': \(myPokemon)")
print()
print("Al llamar a la función, el closure se ejecutará 3 segundos luego.")
print()
