import RxSwift
import UIKit
import SnapKit

final class AllPokemonsViewController: UIViewController
{
    private let contentView: AllPokemonsView
    private let viewModel: IAllPokemonsViewModel
    private let disposeBag = DisposeBag()
    private let router: IAllPokemonsRouter
    
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
        
        self.viewModel.getListPokemons()

    }
    
    private func bind() {
        self.viewModel.showDetailPokemonVC.drive { [weak self] url in
            self?.router.showDetailPokemonVC(url: url)
        }.disposed(by: disposeBag)
    }
    
}

