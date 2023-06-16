import Foundation

protocol IAllPokemonNetworkManager: AnyObject
{
    func getStartedListPokemon(url: String, completion: @escaping([PokemonEntry]) -> (), completionError: @escaping(_ error: String) -> ())
    func getSearchPokemon(url: String, completion: @escaping(Pokemon) -> (), completionError: @escaping(_ error: String) -> ())
}

final class AllPokemonNetworkManager: IAllPokemonNetworkManager
{
    func getStartedListPokemon(url: String, completion: @escaping([PokemonEntry]) -> (), completionError: @escaping(_ error: String) -> ()) {
        
        guard let url = URL(string: url) else {
            completionError("Missing URL")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completionError("Internet connection lost")
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decoded = try JSONDecoder().decode(Pokemons.self, from: data)
                        completion(decoded.results)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getSearchPokemon(url: String, completion: @escaping(Pokemon) -> (), completionError: @escaping(_ error: String) -> ()) {
        
        guard let url = URL(string: url) else {
            completionError("Missing URL")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completionError("Internet connection lost")
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decoded = try JSONDecoder().decode(Pokemon.self, from: data)
                        completion(decoded)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            } else {
                completionError("Pokémon name or id entered incorrectly")
            }
        }
        dataTask.resume()
    }
}
