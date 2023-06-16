import UIKit

protocol IAllPokemonsRouter: AnyObject
{
    var viewController: UIViewController? { get set }
    func showDetailPokemonVC(url: String)
}

final class AllPokemonsRouter: IAllPokemonsRouter
{
    weak var viewController: UIViewController?
    
    func showDetailPokemonVC(url: String) {
        let detailPokemonsViewModel = DetailPokemonsViewModel()
        let vc = DetailPokemonViewController(viewModel: detailPokemonsViewModel)
        detailPokemonsViewModel.fetchPokemons = { [weak self] in
            (self?.viewController as? AllPokemonsViewController)?.getPokemons()
        }
        vc.url = url
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}


