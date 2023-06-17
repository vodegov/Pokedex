import UIKit
import RxSwift

class DetailPokemonViewController: UIViewController
{
    // MARK: - var/let
    
    var url = String()
    private let contentView: DetailPokemonsView
    private let viewModel: IDetailPokemonsViewModel
    private let disposeBag = DisposeBag()
    private lazy var viewLoader: UIView = {
        let viewLoader = UIView()
        viewLoader.translatesAutoresizingMaskIntoConstraints = false
        viewLoader.backgroundColor = .black
        let indicator = UIActivityIndicatorView(frame: .init(x: UIScreen.main.bounds.midX - 25, y: UIScreen.main.bounds.midY - 50, width: 50, height: 50))
        
        indicator.startAnimating()
        viewLoader.addSubview(indicator)
        
        return viewLoader
        
    }()
    private var like: Bool = false
    private let alert = Alert()
    private let appDelegate = AppDelegate()
    
    
    init(viewModel: IDetailPokemonsViewModel) {
        self.viewModel = viewModel
        self.contentView = DetailPokemonsView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = contentView
    }
   
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        self.setLoaderView()
        self.viewModel.getPokemonDetail(url: url)
        self.bind()
    }
}

// MARK: - extension
private extension DetailPokemonViewController
{
    func setLoaderView() {
        self.view.addSubview(viewLoader)
        self.viewLoader.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func bind() {
        self.viewModel.pokemonDownloadCompleted.drive { [weak self] _ in
            self?.viewLoader.removeFromSuperview()
            self?.checkOnLiked()
        }.disposed(by: disposeBag)
        self.viewModel.pokemonDetailFailed.drive { [weak self] error in
            self?.showAlertError(title: error)
        }.disposed(by: disposeBag)
        
        self.appDelegate.errorHandler = { [weak self] error in
            self?.showAlertError(title: error)
        }
        
    }
    
    @objc func btnHeartTapped() {
        if like == false {
            self.enableHeartButton()
            self.viewModel.writeToDbPokemon(url: self.url)
        } else {
            self.disableHeartButton()
            self.viewModel.deleteFromDbPokemon()
        }
        self.like.toggle()
    }
    
    func checkOnLiked() {
        let checkOnHavePokemon = self.viewModel.haveAPokemon(url: self.url)
        if checkOnHavePokemon {
            self.like = true
            self.enableHeartButton()
        } else {
            self.like = false
            self.disableHeartButton()
        }
    }
    
    func enableHeartButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(btnHeartTapped)
        )
    }
    
    func disableHeartButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(btnHeartTapped)
        )
    }
    
    func showAlertError(title: String) {
        self.alert.showAlertError(title: "Sorry", msg: title, on: self)
    }
}


