import UIKit

protocol IFavoritesPokemonsRouter: AnyObject
{
    var viewController: UIViewController? { get set }
    func showDetailPokemonVC(url: String)
    func showAllPokemonVC()
}

final class FavoritesPokemonsRouter: IFavoritesPokemonsRouter
{
    weak var viewController: UIViewController?
    private let detailPokemonsViewModel = DetailPokemonsViewModel()
    
    
    func showDetailPokemonVC(url: String) {
        let vc = DetailPokemonViewController(viewModel: self.detailPokemonsViewModel)
        vc.url = url
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAllPokemonVC() {
        self.viewController?.tabBarController?.selectedIndex = 0
    }
}
