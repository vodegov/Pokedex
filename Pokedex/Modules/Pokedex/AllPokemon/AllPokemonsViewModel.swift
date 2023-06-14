import Foundation
import RxRelay
import RxCocoa

protocol IAllPokemonsViewModel: AnyObject
{
    var pokemonArray: Driver<[PokemonEntry]> { get }
    var pokemonSearch: Driver<String> { get }
    var showDetailPokemonVC: Driver<String> { get }
    func getListPokemons()
    func getSearchPokemon(name: String)
    func cellTapped(with url: String)
}

final class AllPokemonsViewModel: IAllPokemonsViewModel
{
    var pokemonArray: Driver<[PokemonEntry]> {
        self.pokemonArrayRelay.asDriver(onErrorJustReturn: [])
    }
    var pokemonSearch: Driver<String> {
        self.pokemonSearchRelay.asDriver(onErrorJustReturn: "")
    }
    var showDetailPokemonVC: Driver<String> {
        self.showDetailPokemonVCRelay.asDriver(onErrorJustReturn: "")
    }
    private let pokemonArrayRelay = PublishRelay<[PokemonEntry]>()
    private let pokemonSearchRelay = PublishRelay<String>()
    private let showDetailPokemonVCRelay = PublishRelay<String>()
    private let networkManager = AllPokemonNetworkManager()
    
    
    func getListPokemons() {
        let url = Constants.URLs.allPokemonsUrl
        self.networkManager.getStartedListPokemon(url: url) { [weak self] pokemonEntryArray in
            self?.pokemonArrayRelay.accept(pokemonEntryArray)
        }
    }
    
    func getSearchPokemon(name: String) {
        let url = Constants.URLs.searchPokemon + name
        self.networkManager.getSearchPokemon(url: url) { [weak self] _ in
            self?.pokemonSearchRelay.accept(url)
            
        }
    }
    
    func cellTapped(with url: String) {
        self.showDetailPokemonVCRelay.accept(url)
    }
    
}
