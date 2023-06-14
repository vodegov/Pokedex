
import UIKit

enum Constants
{
    enum Colors
    {
        static let background = UIColor.black
        static let defaulText = UIColor.white
        static let aboutPokemonText = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    }
    
    enum Fonts
    {
        static let defaulText = UIFont.systemFont(ofSize: 14, weight: .medium)
        static let nameText = UIFont.systemFont(ofSize: 32, weight: .semibold)
        static let nameMoveText = UIFont.systemFont(ofSize: 24, weight: .semibold)
        static let nameTextEvolution = UIFont.systemFont(ofSize: 19, weight: .medium)
        static let aboutPokemonText = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    enum Layout
    {
        static let horizontalSpace = 24
        static let verticalSpace = 8
    }
    
    enum URLs
    {
//        static let allPokemonsUrl = "https://pokeapi.co/api/v2/pokemon/"
        static let allPokemonsUrl = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1281"
        static let searchPokemon = "https://pokeapi.co/api/v2/pokemon/"
        static let pokemonImagePreview = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    }
    
    enum SegmentControllIndex: Int
    {
        case About = 0
        case Stats
        case Moves
        case Evolutions
    }
}
