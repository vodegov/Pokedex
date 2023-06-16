import Foundation
import RxCocoa
import RxSwift

protocol IFavoritesPokemonsViewModel: AnyObject
{
    var pokemonArray: Driver<[PokemonEntryCoreData]> { get }
    var showDetailPokemonVC: Driver<String> { get }
    func getListPokemons()
    func deletePokemonFromDb(name: String)
    func deleteAllPokemonFromDb()
    func cellTapped(with url: String)
}

final class FavoritesPokemonsViewModel: IFavoritesPokemonsViewModel
{
    var pokemonArray: Driver<[PokemonEntryCoreData]> {
        self.pokemonArrayRelay.asDriver(onErrorJustReturn: [])
    }
    var showDetailPokemonVC: Driver<String> {
        self.showDetailPokemonVCRelay.asDriver(onErrorJustReturn: "")
    }
    private let disposeBag = DisposeBag()
    private let pokemonArrayRelay = PublishRelay<[PokemonEntryCoreData]>()
    private let showDetailPokemonVCRelay = PublishRelay<String>()
    private let dataManager = StoregeManager.shared
    
    init (){
        self.dataManager.reloadData.bind { [weak self] _ in
            self?.getListPokemons()
        }.disposed(by: disposeBag)
    }
    
    func getListPokemons() {
        let pokemonArray = self.dataManager.fetchPokemons()
        self.pokemonArrayRelay.accept(pokemonArray)
    }
    
    func deletePokemonFromDb(name: String) {
        self.dataManager.deletePokemon(name: name)
    }
    
    func deleteAllPokemonFromDb() {
        self.dataManager.deleteAllPokemons()
    }
    
    func cellTapped(with url: String) {
        self.showDetailPokemonVCRelay.accept(url)
    }
}
