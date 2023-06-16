import UIKit
import RxSwift

final class FavoritesPokemonsViewController: UIViewController
{
    private let contentView: FavoritesPokemonsView
    private let viewModel: IFavoritesPokemonsViewModel
    private let router: IFavoritesPokemonsRouter
    private let disposeBag = DisposeBag()
    private let alert = Alert()
    
    init(viewModel: IFavoritesPokemonsViewModel, router: IFavoritesPokemonsRouter) {
        self.viewModel = viewModel
        self.contentView = FavoritesPokemonsView(viewModel: viewModel)
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.contentView.hideOrShowElement()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        self.bind()
        self.getPokemons()
        self.configureNavBar()
    }
}

private extension FavoritesPokemonsViewController
{
    func bind() {
        self.viewModel.showDetailPokemonVC.drive { [weak self] url in
            self?.router.showDetailPokemonVC(url: url)
        }.disposed(by: disposeBag)
        
        self.contentView.buttonShowPokedexHandler = { [weak self] in
            self?.router.showAllPokemonVC()
        }
        self.alert.alertDeletehandler = { [weak self] in
            self?.btnYesAlertDeleteTapped()
        }
        
    }
    
    func configureNavBar() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "trash.fill"),
            style: .plain,
            target: self,
            action: #selector(btnTrashTapped)
        )
    }
    
    func getPokemons() {
        self.viewModel.getListPokemons()
    }
    
    @objc func btnTrashTapped() {
        self.alert.showAlertDelete(title: "Are you shure?",
                                   msg: "What do you want to remove all Pokémon",
                                   on: self)
    }
    
    func btnYesAlertDeleteTapped() {
        self.viewModel.deleteAllPokemonFromDb()
        self.viewModel.getListPokemons()
        self.contentView.hideOrShowElement()
    }
}
