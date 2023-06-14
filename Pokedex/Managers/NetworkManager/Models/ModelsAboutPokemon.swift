import Foundation

struct AboutPokemon: Decodable
{
    let id: Int
    let genera: [GeneraPokemon]?
    let flavor_text_entries: [Flavor]?
    let evolution_chain: UrlEvolution
    let name: String
    static let emptyAboutPokemon = AboutPokemon(id: 0, genera: [], flavor_text_entries: [], evolution_chain: UrlEvolution(url: ""), name: "")
}

struct GeneraPokemon: Decodable
{
    let genus: String
    let language: Language
}

struct Flavor: Decodable
{
    let flavor_text: String
    let language: Language
    let version: VersionFlavor
}

struct Language: Decodable
{
    let name: String
}

struct VersionFlavor: Decodable
{
    let name: String
}

struct UrlEvolution: Decodable
{
    let url: String
}
