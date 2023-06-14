import Foundation

final class PokemonMaper
{
    func getPokemonImageUrl(model: Pokemon) -> String {
        let imageUrl = model.sprites.other.home.front_default
        
        return imageUrl
    }
    
    func getPokemonType(model: Pokemon) -> String {
        let type = model.types.first?.type.name ?? "Normal"
        
        return type
    }
    
    func getUrlAboutPokemon(model: Pokemon) -> String {
        let url = model.species.url
        
        return url
    }
    
    func getUrlAboutEvolutionPokemon(model: Pokemon) -> String {
        guard let url = model.aboutPokemon?.evolution_chain.url else { fatalError("") }
        
        return url
    }
    
    
    func getPokemonGenus(model: Pokemon) -> String? {
        for i in model.aboutPokemon?.genera ?? [] {
            if i.language.name == "en" {
                return i.genus
            }
        }
        return nil
    }
    
    func getPokemonAboutText(model: Pokemon) -> String? {
        for i in model.aboutPokemon?.flavor_text_entries ?? [] {
            if i.language.name == "en", i.version.name == "ruby" {
                return i.flavor_text
            }
        }
        return nil
    }
    
    func getEvolutionDataimage(model: Pokemon, name: String) -> Data? {
        for i in model.evolution?.chain?.arrayOfIdImage ?? [] {
            if i.name == name {
                return i.imageData
            }
        }
        
        return nil
    }
    
    func getPokemonHp(model: Pokemon) -> Int? {
        for i in model.stats {
            if i.stat.name == "hp" {
                return i.base_stat
            }
        }
        return nil
    }
    
    func getPokemonAttack(model: Pokemon) -> Int? {
        for i in model.stats {
            if i.stat.name == "attack" {
                return i.base_stat
            }
        }
        return nil
    }
    
    func getPokemonDefense(model: Pokemon) -> Int? {
        for i in model.stats {
            if i.stat.name == "defense" {
                return i.base_stat
            }
        }
        return nil
    }
    
    func getPokemonSpecialAttack(model: Pokemon) -> Int? {
        for i in model.stats {
            if i.stat.name == "special-attack" {
                return i.base_stat
            }
        }
        return nil
    }
    
    func getPokemonSpecialDefense(model: Pokemon) -> Int? {
        for i in model.stats {
            if i.stat.name == "special-defense" {
                return i.base_stat
            }
        }
        return nil
    }
    
    func getPokemonSpeed(model: Pokemon) -> Int? {
        for i in model.stats {
            if i.stat.name == "speed" {
                return i.base_stat
            }
        }
        return nil
    }
}
