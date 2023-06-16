import RxSwift
import UIKit
import SnapKit

protocol IAllPokemonsViewController: AnyObject
{
    func getPokemons()
}
final class AllPokemonsViewController: UIViewController, IAllPokemonsViewController
{
    private let contentView: AllPokemonsView
    private let viewModel: IAllPokemonsViewModel
    private let disposeBag = DisposeBag()
    private let router: IAllPokemonsRouter
    private let alert = Alert()
    
    init(viewModel: IAllPokemonsViewModel, router: IAllPokemonsRouter) {
        self.viewModel = viewModel
        self.contentView = AllPokemonsView(viewModel: viewModel)
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokedex"
        self.bind()
        self.getPokemons()
    }
    
    func getPokemons() {
        self.viewModel.getListPokemons()
    }
}

private extension AllPokemonsViewController
{
    private func showAlert() {
        self.alert.showAlertIncorrectName(on: self)
    }
    
    private func bind() {
        self.viewModel.showDetailPokemonVC.drive { [weak self] url in
            self?.router.showDetailPokemonVC(url: url)
        }.disposed(by: disposeBag)
        self.viewModel.pokemonSearchFailed.drive { [weak self] _ in
            self?.showAlert()
        }.disposed(by: disposeBag)
    }
}

