import CoreData
import UIKit
import RxCocoa

protocol IStoregeManager: AnyObject
{
    var reloadData: PublishRelay<Void> { get }
    func createPokemon(model: CreatePokemonModel)
    func fetchPokemons() -> [PokemonEntryCoreData]
    func fetchPokemon(url: String) -> PokemonEntryCoreData?
    func deleteAllPokemons()
    func deletePokemon(name: String)
}

final class StoregeManager: NSObject, IStoregeManager
{
    var reloadData = PublishRelay<Void>()
    static let shared = StoregeManager()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func createPokemon(model: CreatePokemonModel) {
        guard let pokemonEntryEntityDescription = NSEntityDescription.entity(forEntityName: "PokemonEntryCoreData", in: context) else {
            return
        }
        let pokemonEntry = PokemonEntryCoreData(entity: pokemonEntryEntityDescription, insertInto: context)
        
        pokemonEntry.id = model.id
        pokemonEntry.name = model.name
        pokemonEntry.url = model.url
        pokemonEntry.image = model.imageData
        pokemonEntry.type = model.type
        pokemonEntry.genus = model.genus

        self.appDelegate.saveContext()
        self.reloadData.accept(())
    }
    
    func fetchPokemons() -> [PokemonEntryCoreData] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PokemonEntryCoreData")
        do {
            return (try? context.fetch(fetchRequest) as? [PokemonEntryCoreData]) ?? []
        }
    }
    
    func fetchPokemon(url: String) -> PokemonEntryCoreData? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PokemonEntryCoreData")
        do {
            guard let pokemonEntry = try? context.fetch(fetchRequest) as? [PokemonEntryCoreData],
                  let pokemon = pokemonEntry.first(where: { $0.url == url }) else { return nil }
            return pokemon
        }
    }
    
    func deleteAllPokemons() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PokemonEntryCoreData")
        do {
            let pokemonEntry = try? context.fetch(fetchRequest) as? [PokemonEntryCoreData]
            pokemonEntry?.forEach { context.delete($0) }
        }
        self.appDelegate.saveContext()
        self.reloadData.accept(())
    }
    
    func deletePokemon(name: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PokemonEntryCoreData")
        do {
            guard let pokemonEntry = try? context.fetch(fetchRequest) as? [PokemonEntryCoreData],
                  let pokemon = pokemonEntry.first(where: { $0.name == name }) else { return }
            context.delete(pokemon)
        }
        self.appDelegate.saveContext()
        self.reloadData.accept(())
    }
    
}
