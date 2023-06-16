import UIKit
import Kingfisher

final class AllPokemonsTableViewCell: UITableViewCell
{
    // MARK: - var/let
    private lazy var idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.font = Constants.Fonts.defaulText
        idLabel.textColor = Constants.Colors.aboutPokemonText
        
        return idLabel
    }()
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = Constants.Colors.defaulText
        
        return nameLabel
    }()
    private let image = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ITableViewCell
extension AllPokemonsTableViewCell: ITableViewCell
{
    typealias Model = AllPokemonsCellModel
    func configure(model: Model) {
        self.idLabel.text = String(format: "#%03d", model.id)
        self.nameLabel.text = model.name
        self.image.kf.setImage(with: URL(string: model.url))
    }
}

// MARK: - private extension
private extension AllPokemonsTableViewCell
{
    func buildUI() {
        self.contentView.addSubview(idLabel)
        self.idLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
                .inset(Constants.Layout.horizontalSpace)
        }
        
        self.contentView.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.idLabel.snp.trailing)
                .inset(-Constants.Layout.horizontalSpace)
        }
        
        self.contentView.addSubview(image)
        self.image.contentMode = .scaleToFill
        self.image.kf.indicatorType = .activity
        self.image.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
                .inset(Constants.Layout.horizontalSpace)
            make.size.equalTo(70)
        }
    }
}
