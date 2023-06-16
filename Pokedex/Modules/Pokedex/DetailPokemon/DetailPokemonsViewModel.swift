import Foundation
import RxCocoa

protocol IDetailPokemonsViewModel: AnyObject
{
    var fetchPokemons: (() -> ())? { get set }
    var pokemonDetail: Driver<Pokemon> { get }
    var pokemonDetailFailed: RxCocoa.Driver<String> { get }
    var pokemonDownloadCompleted: Driver<Bool> { get }
    var pokemonEvolutionImages: Driver<[String: Data]> { get }
    func getPokemonDetail(url: String)
    func writeToDbPokemon(url: String)
    func deleteFromDbPokemon()
    func haveAPokemon(url: String) -> Bool
}

final class DetailPokemonsViewModel: IDetailPokemonsViewModel
{
    // MARK: - var/let
    var pokemonDetail: RxCocoa.Driver<Pokemon> {
        self.pokemonDetailRelay.asDriver(onErrorJustReturn: Pokemon.emptyPokemon)
    }
    var pokemonDetailFailed: RxCocoa.Driver<String> {
        self.pokemonDetailFailedRelay.asDriver(onErrorJustReturn: "")
    }
    var pokemonDownloadCompleted: RxCocoa.Driver<Bool> {
        self.pokemonDownloadCompletedRelay.asDriver(onErrorJustReturn: false)
    }
    var pokemonEvolutionImages: RxCocoa.Driver<[String: Data]> {
        self.pokemonEvolutionImagesRelay.asDriver(onErrorJustReturn: [:])
    }
    var fetchPokemons: (() -> ())?
    private let pokemonDetailRelay = BehaviorRelay<Pokemon>(value: Pokemon.emptyPokemon)
    private let pokemonDownloadCompletedRelay = PublishRelay<Bool>()
    private let pokemonDetailFailedRelay = PublishRelay<String>()
    private let pokemonEvolutionImagesRelay = PublishRelay<[String: Data]>()
    private let networkManager = DetailNetworkManager()
    private let dataManager = StoregeManager.shared
    private let pokemonMaper = PokemonMaper()
    
    // MARK: - func
    
    func getPokemonDetail(url: String) {
        self.networkManager.getDetailPokemon(url: url) { [weak self] pokemonDetail in
            
            let urlImage = self?.pokemonMaper.getPokemonImageUrl(model: pokemonDetail)
            let urlInfo = self?.pokemonMaper.getUrlAboutPokemon(model: pokemonDetail)
            
            self?.networkManager.getDetailImage(model: pokemonDetail, url: urlImage ?? "", completion: { [weak self] pokemonDetailWithImage in
                
                self?.networkManager.getInfoAboutPokemon(model: pokemonDetailWithImage, url: urlInfo ?? "", completion: { [weak self] pokemonDetailWithInfo in
                    
                    guard let urlEvolution = self?.pokemonMaper.getUrlAboutEvolutionPokemon(model: pokemonDetailWithInfo) else { return }
                    self?.networkManager.getEvolutionPokemon(model: pokemonDetailWithInfo, url: urlEvolution, completion: { [weak self] pokemonDetailWithEvolution in
                        
                        let arrayOfUrls = self?.getArrayUrls(model: pokemonDetailWithEvolution) ?? []
                        self?.getEvolutionPokemonImages(urls: arrayOfUrls)
                        self?.pokemonDetailRelay.accept(pokemonDetailWithEvolution)
                        self?.pokemonDownloadCompletedRelay.accept(true)
                    })
                })
            })
        } completionError: { [weak self] error in
            self?.pokemonDetailFailedRelay.accept(error)
        }
    }
    
    func haveAPokemon(url: String) -> Bool {
        self.dataManager.fetchPokemon(url: url) != nil
    }
    
    func writeToDbPokemon(url: String) {
        let pokemon = pokemonDetailRelay.value
        let genus = self.pokemonMaper.getPokemonGenus(model: pokemon)
        let model = CreatePokemonModel(id: String(pokemon.aboutPokemon?.id ?? 0),
                                       name: pokemon.name,
                                       url: url,
                                       imageData: pokemon.image,
                                       type: pokemon.types.first?.type.name,
                                       genus: genus)
        self.dataManager.createPokemon(model: model)
        self.fetchPokemons?()
    }
    
    func  deleteFromDbPokemon() {
        let pokemon = pokemonDetailRelay.value
        self.dataManager.deletePokemon(name: pokemon.name)
        self.fetchPokemons?()
    }
}

// MARK: - extension
private extension DetailPokemonsViewModel
{
    func getArrayUrls(model: Pokemon) -> [String] {
        var tempArray: [String] = []
        let evo = model.evolution?.chain
        
        if let url = evo?.species.url {
            tempArray.append(url)
        }
        if let url = evo?.evolves_to?.first?.species.url {
            tempArray.append(url)
        }
        if let url = evo?.evolves_to?.first?.evolves_to?.first?.species.url {
            tempArray.append(url)
        }
        
        if let url = evo?.evolves_to?.first?.evolves_to?.first?.evolves_to?.first?.species.url {
            tempArray.append(url)
        }
        
        return tempArray
    }
    
    
    func getEvolutionPokemonImages(urls: [String]) {
        var tempDict: [String: Data] = [:]
        for url in urls {
            self.networkManager.getIdPokemon(url: url, completion: { [weak self] id, name  in
                self?.networkManager.getEvolutionPokemonImages(id: id, completion: { dataImage in
                    tempDict[name] = dataImage
                    self?.pokemonEvolutionImagesRelay.accept(tempDict)
                })
            })
        }
    }
}

