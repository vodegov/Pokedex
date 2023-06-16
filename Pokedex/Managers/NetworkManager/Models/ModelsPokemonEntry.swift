import Foundation

struct Pokemons: Decodable
{
    let results: [PokemonEntry]
}

struct PokemonEntry: Decodable {
    let name: String
    let url: String
}
