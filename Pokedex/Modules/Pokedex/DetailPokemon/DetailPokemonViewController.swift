import UIKit
import RxSwift

class DetailPokemonViewController: UIViewController
{
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
        self.setLoaderView()
        configureNavBar()
        self.viewModel.getPokemonDetail(url: url)
        self.bind()
    }

}

// MARK: - extension

extension DetailPokemonViewController
{
    func setLoaderView() {
        self.view.addSubview(viewLoader)
        self.viewLoader.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func bind() {
        self.viewModel.pokemonDownload.drive { [weak self] _ in
            self?.viewLoader.removeFromSuperview()
        }.disposed(by: disposeBag)
    }
    
    func configureNavBar() {
        let qwe = UIButton(type: .system)
        qwe.setImage(UIImage(systemName: "heart"), for: .normal)
        qwe.tintColor = .white
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                                                 style: .plain, target: self, action: #selector(btnHeartTapped))
    }
    
    @objc func btnHeartTapped() {
        print("tapped")
        if like == false {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"),
                                                                     style: .plain, target: self, action: #selector(btnHeartTapped))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                                                     style: .plain, target: self, action: #selector(btnHeartTapped))
        }
        self.like.toggle()
    }
}


