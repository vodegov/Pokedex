import Foundation

struct Pokemons: Codable
{
    let results: [PokemonEntry]
}

struct PokemonEntry: Codable {
    let name: String
    let url: String
    var image: Data?
}
