import UIKit

protocol IAllPokemonsRouter: AnyObject
{
    var viewController: UIViewController? { get set }
    func showDetailPokemonVC(url: String)
}

final class AllPokemonsRouter: IAllPokemonsRouter
{
    weak var viewController: UIViewController?
    private let detailPokemonsViewModel = DetailPokemonsViewModel()
    
    
    func showDetailPokemonVC(url: String) {
        let vc = DetailPokemonViewController(viewModel: self.detailPokemonsViewModel)
        vc.url = url
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}



