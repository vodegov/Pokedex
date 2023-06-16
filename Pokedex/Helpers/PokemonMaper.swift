import Foundation

final class PokemonMaper
{
    func getPokemonImageUrl(model: Pokemon?) -> String? {
        model?.sprites?.other?.home?.front_default
    }
    
    func getPokemonType(model: Pokemon?) -> String {
        model?.types.first?.type.name ?? "Normal"
    }
    
    func getUrlAboutPokemon(model: Pokemon) -> String {
        model.species.url
    }
    
    func getUrlAboutEvolutionPokemon(model: Pokemon?) -> String? {
        model?.aboutPokemon?.evolution_chain.url
    }
    
    
    func getPokemonGenus(model: Pokemon?) -> String? {
        model?.aboutPokemon?.genera?.first(where: {$0.language.name == "en"})?.genus
    }
    
    func getPokemonAboutText(model: Pokemon?) -> String? {
        model?.aboutPokemon?.flavor_text_entries?.first(where: {$0.language.name == "en" && $0.version.name == "ruby"})?.flavor_text
    }
    
    func getEvolutionDataimage(model: Pokemon, name: String) -> Data? {
        model.evolution?.chain?.arrayOfIdImage?.first(where: {$0.name == name})?.imageData
    }
    
    func getPokemonHp(model: Pokemon?) -> Int {
        model?.stats.first(where: {$0.stat.name == "hp"})?.base_stat ?? 0
    }
    
    func getPokemonAttack(model: Pokemon?) -> Int {
        model?.stats.first(where: {$0.stat.name == "attack"})?.base_stat ?? 0
    }
    
    func getPokemonDefense(model: Pokemon?) -> Int {
        model?.stats.first(where: {$0.stat.name == "defense"})?.base_stat ?? 0
    }
    
    func getPokemonSpecialAttack(model: Pokemon?) -> Int {
        model?.stats.first(where: {$0.stat.name == "special-attack"})?.base_stat ?? 0
    }
    
    func getPokemonSpecialDefense(model: Pokemon?) -> Int {
        model?.stats.first(where: {$0.stat.name == "special-defense"})?.base_stat ?? 0
    }
    
    func getPokemonSpeed(model: Pokemon?) -> Int {
        model?.stats.first(where: {$0.stat.name == "speed"})?.base_stat ?? 0
    }
}
