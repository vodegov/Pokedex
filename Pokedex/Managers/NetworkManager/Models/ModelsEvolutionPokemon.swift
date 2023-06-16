import Foundation

struct Evolution: Decodable
{
    var chain: Chain?
    let id: Int
    static let emptyEvolution = Evolution(chain: Chain(evolution_details: [], evolves_to: [], species: СurrentFormDetail(name: "", url: "")), id: 0)
}

struct Chain: Decodable
{
    let evolution_details: [EvolutionDetail]?
    let evolves_to: [Chain]?
    var species: СurrentFormDetail
    var arrayOfIdImage: [ArrayOfIdImage]?
}

struct ArrayOfIdImage: Decodable
{
    var id: Int
    var imageData: Data
    var name: String
}

struct EvolutionDetail: Decodable
{
    let min_level: Int?
}

struct СurrentFormDetail: Decodable
{
    let name: String
    let url: String
}


