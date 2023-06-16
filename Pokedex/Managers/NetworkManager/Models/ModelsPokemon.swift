import Foundation

struct Pokemon: Decodable
{
    let name: String
    let weight: Int
    let height: Int
    let base_experience: Int?
    let types: [Types]
    let stats: [Stats]
    let sprites: MainImage?
    let species: Species
    var aboutPokemon: AboutPokemon?
    var evolution: Evolution?
    let moves: [Moves]
    var image: Data?
    static let emptyPokemon = Pokemon(name: "", weight: 0, height: 0, base_experience: 0, types: [], stats: [], sprites: MainImage(other: Image(home: URLImage(front_default: ""))), species: Species(url: ""), moves: [], image: nil)
}

struct Types: Decodable
{
    let slot: Int
    let type: TypeName
}

struct TypeName: Decodable
{
    let name: String
}

struct Stats: Decodable
{
    let base_stat: Int
    let stat: StatName
}

struct StatName: Decodable
{
    let name: String
}

struct MainImage: Decodable
{
    let other: Image?
}

struct Image: Decodable
{
    let home: URLImage?
}

struct URLImage: Decodable
{
    let front_default: String?
}

struct Species: Decodable
{
    let url: String
}

struct Moves: Decodable
{
    let move: DetailMove
}

struct DetailMove: Decodable
{
    let name: String
    let url: String
}
