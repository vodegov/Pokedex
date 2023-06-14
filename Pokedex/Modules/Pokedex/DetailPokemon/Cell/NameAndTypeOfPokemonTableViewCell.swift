
import UIKit

class NameAndTypeOfPokemonTableViewCell: UITableViewCell
{
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = Constants.Colors.defaulText
        nameLabel.font = Constants.Fonts.nameText
        
        return nameLabel
    }()
    private lazy var genusLabel: UILabel = {
        let genusLabel = UILabel()
        genusLabel.textColor = Constants.Colors.aboutPokemonText
        genusLabel.font = Constants.Fonts.aboutPokemonText
        
        return genusLabel
    }()
    private lazy var typeStackView: UIStackView = {
        let typeStackView = UIStackView()
        typeStackView.axis = .horizontal
        typeStackView.spacing = 4
        
        return typeStackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, genus: String, model: [Types]) {
        self.nameLabel.text = name
        self.genusLabel.text = genus
        if typeStackView.arrangedSubviews.isEmpty {
            for type in model {
                self.typeStackView.addArrangedSubview(UIImageView.init(image: UIImage(named: "icon-\(type.type.name)")))
            }
        }
        
    }

}

private extension NameAndTypeOfPokemonTableViewCell
{
    func buildUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.contentView.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.contentView.addSubview(genusLabel)
        self.genusLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom)
                .inset(-Constants.Layout.verticalSpace)
            make.centerX.equalToSuperview()
        }
        
        self.contentView.addSubview(typeStackView)
        self.typeStackView.snp.makeConstraints { make in
            make.top.equalTo(self.genusLabel.snp.bottom)
                .inset(-Constants.Layout.verticalSpace)
            make.centerX.equalToSuperview()
        }

    }
}
