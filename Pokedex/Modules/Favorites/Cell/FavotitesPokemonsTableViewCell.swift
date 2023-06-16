import UIKit

final class FavoritesPokemonsTableViewCell: UITableViewCell
{
    var buttonLikeHandler: (() -> ())?
    private lazy var idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.font = Constants.Fonts.defaulText
        idLabel.textColor = Constants.Colors.aboutPokemonText
        
        return idLabel
    }()
    private let conteinerForImageType = UIView()
    private let conteinerForNameType = UIView()
    private let pokemonImage = UIImageView()
    private let pokemonTypeImage = UIImageView()
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = Constants.Colors.defaulText
        
        return nameLabel
    }()
    private lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textColor = Constants.Colors.defaulText
        typeLabel.textColor = Constants.Colors.aboutPokemonText
        
        return typeLabel
    }()
    private lazy var buttonLike: UIButton = {
        let buttonLike = UIButton(type: .system)
        buttonLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        buttonLike.tintColor = .white
        buttonLike.addTarget(self,
                             action: #selector(buttonLikeTapped),
                             for: .touchUpInside)
        
        return buttonLike
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoritesPokemonsTableViewCell: ITableViewCell
{
    typealias Model = FavoritesPokemonCellModel
    
    func configure(model: FavoritesPokemonCellModel) {
        let intId = Int(model.id ?? "") ?? 0
        self.idLabel.text = String(format: "#%03d", intId)
        self.pokemonImage.image = UIImage(data: model.dataImage ?? Data())
        self.pokemonTypeImage.image = UIImage(named: "icon-\(model.pokemonType ?? "")")
        self.nameLabel.text = model.name?.capitalized
        self.typeLabel.text = model.genus
    }
}

private extension FavoritesPokemonsTableViewCell
{
    func buildUI() {
        
        self.contentView.addSubview(idLabel)
        self.idLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
                .inset(Constants.Layout.verticalSpace)
        }
        
        self.contentView.addSubview(conteinerForImageType)
        self.conteinerForImageType.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
                .inset(Constants.Layout.horizontalSpace)
        }
        
        self.conteinerForImageType.addSubview(pokemonTypeImage)
        self.conteinerForImageType.addSubview(pokemonImage)
        self.pokemonImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.size.equalTo(Layout.heightImage)
            make.bottom.equalTo(pokemonTypeImage.snp.top)
                .inset(-Constants.Layout.verticalSpace)
        }
        
        self.pokemonTypeImage.contentMode = .scaleAspectFit
        self.pokemonTypeImage.snp.makeConstraints { make in
            make.top.equalTo(pokemonImage.snp.bottom)
                .inset(-Constants.Layout.verticalSpace)
            make.centerX.equalTo(pokemonImage)
            make.bottom.equalToSuperview()
            make.height.equalTo(Layout.heightImageType)
        }
        
        self.contentView.addSubview(self.conteinerForNameType)
        self.conteinerForNameType.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(pokemonImage.snp.trailing)
                .inset(-Constants.Layout.horizontalSpace)
        }
        
        self.conteinerForNameType.addSubview(self.nameLabel)
        self.conteinerForNameType.addSubview(self.typeLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.bottom.equalTo(self.typeLabel.snp.top)
                .inset(-Constants.Layout.verticalSpace)
        }
        
        self.typeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom)
                .inset(-Constants.Layout.verticalSpace)
            make.bottom.horizontalEdges.equalToSuperview()
        }
        
        self.contentView.addSubview(self.buttonLike)
        self.buttonLike.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
                .inset(Constants.Layout.defaultverticalSpace)
        }
    }
    
    @objc func buttonLikeTapped() {
        self.buttonLikeHandler?()
    }
}

fileprivate enum Layout
{
    static let heightImage = 100
    static let heightImageType = 20
}
