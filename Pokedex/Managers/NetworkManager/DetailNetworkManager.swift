
import Foundation

final class DetailNetworkManager
{
    func getDetailPokemon(url: String, completion: @escaping(Pokemon) -> ()) {
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
                        let decoded = try JSONDecoder().decode(Pokemon.self, from: data)
                        completion(decoded)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getDetailImage(model: Pokemon, url: String, completion: @escaping(Pokemon) -> ()) {
        var resultPokemon: Pokemon = model
        guard let url = URL(string: url) else {
            print("Missing Url")
            completion(resultPokemon)
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
                    resultPokemon.image = data
                    completion(resultPokemon)
                }
            }
        }
        dataTask.resume()
    }
    
    func getInfoAboutPokemon(model: Pokemon, url: String, completion: @escaping (Pokemon) -> ()) {
        var resultPokemon: Pokemon = model
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
                        let decoded = try JSONDecoder().decode(AboutPokemon.self, from: data)
                        resultPokemon.aboutPokemon = decoded
                        completion(resultPokemon)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getEvolutionPokemon(model: Pokemon, url: String, completion: @escaping (Pokemon) -> ()) {
        var resultPokemon: Pokemon = model
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
                        let decoded = try JSONDecoder().decode(Evolution.self, from: data)
                        resultPokemon.evolution = decoded
                        completion(resultPokemon)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getIdPokemon(url: String, completion: @escaping (Int, String) -> ()) {
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
                        let decoded = try JSONDecoder().decode(AboutPokemon.self, from: data)
                        completion(decoded.id, decoded.name)
                        
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getEvolutionPokemonImages(id: Int, completion: @escaping (Data) -> ()) {
        guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id).png") else { fatalError("Missing URL") }

        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }
        dataTask.resume()
    }
}
