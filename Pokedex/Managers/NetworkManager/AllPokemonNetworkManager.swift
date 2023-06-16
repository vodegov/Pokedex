import Foundation

final class AllPokemonNetworkManager
{
    func getStartedListPokemon(url: String, completion: @escaping([PokemonEntry]) -> ()) {
        
        guard let url = URL(string: url) else { fatalError("Missing URL") }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
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
            if let error = error {
                print("Request error: ", error)
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
                completionError("Missing URL")
            }
        }
        dataTask.resume()
    }
}
