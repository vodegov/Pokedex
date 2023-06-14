import Foundation
import RxRelay
import RxCocoa

protocol IDetailPokemonsViewModel: AnyObject
{
    var pokemonDetail: Driver<Pokemon> { get }
    var pokemonDownload: Driver<Bool> { get }
    var pokemonEvolutionImages: Driver<[String: Data]> { get }
    func getPokemonDetail(url: String)
}

final class DetailPokemonsViewModel: IDetailPokemonsViewModel
{
    var pokemonDetail: RxCocoa.Driver<Pokemon> {
        self.pokemonDetailRelay.asDriver(onErrorJustReturn: Pokemon.emptyPokemon)
    }
    var pokemonDownload: RxCocoa.Driver<Bool> {
        self.pokemonDownloadRelay.asDriver(onErrorJustReturn: false)
    }
    var pokemonEvolutionImages: RxCocoa.Driver<[String: Data]> {
        self.pokemonEvolutionImagesRelay.asDriver(onErrorJustReturn: [:])
    }
    private let pokemonDetailRelay = PublishRelay<Pokemon>()
    private let pokemonDownloadRelay = PublishRelay<Bool>()
    private let pokemonEvolutionImagesRelay = PublishRelay<[String: Data]>()
    private let networkManager = DetailNetworkManager()
    private let pokemonMaper = PokemonMaper()
    
    func getPokemonDetail(url: String) {
        self.networkManager.getDetailPokemon(url: url) { [weak self] pokemonDetail in
            
            guard let urlImage = self?.pokemonMaper.getPokemonImageUrl(model: pokemonDetail) else { return }
            guard let urlInfo = self?.pokemonMaper.getUrlAboutPokemon(model: pokemonDetail) else { return }
            
            self?.networkManager.getDetailImage(model: pokemonDetail, url: urlImage, completion: { [weak self] pokemonDetailWithImage in
                
                self?.networkManager.getInfoAboutPokemon(model: pokemonDetailWithImage, url: urlInfo, completion: { [weak self] pokemonDetailWithInfo in
                    
                    guard let urlEvolution = self?.pokemonMaper.getUrlAboutEvolutionPokemon(model: pokemonDetailWithInfo) else { return }
                    self?.networkManager.getEvolutionPokemon(model: pokemonDetailWithInfo, url: urlEvolution, completion: { [weak self] pokemonDetailWithEvolution in
                        
                        let arrayOfUrls = self?.getArrayUrls(model: pokemonDetailWithEvolution) ?? []
                        self?.getEvolutionPokemonImages(urls: arrayOfUrls)
                        self?.pokemonDetailRelay.accept(pokemonDetailWithEvolution)
                    })
                })
            })
        }
    }
}

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
                    self?.pokemonDownloadRelay.accept(true)
                })
            })
        }
    }
}

