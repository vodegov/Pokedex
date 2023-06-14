import UIKit
import Kingfisher

//protocol IAllPokemonsTableViewCell: AnyObject
//{
//    func configure(name: String)
//}

final class AllPokemonsTableViewCell: UITableViewCell
{
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
    
    func configure(name: String, url: String) {
        self.nameLabel.text = name
        self.image.kf.setImage(with: URL(string: url))
    }
    
}

//extension AllPokemonsTableViewCell: IAllPokemonsTableViewCell
//{
//    
//}

private extension AllPokemonsTableViewCell
{
    func buildUI() {
        
        self.contentView.addSubview(image)
        self.contentView.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.image.snp.trailing)
                .inset(-Constants.Layout.horizontalSpace)
        }
        
        self.image.contentMode = .scaleToFill
        self.image.kf.indicatorType = .activity
        self.image.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
                .inset(Constants.Layout.horizontalSpace)
            make.size.equalTo(70)
        }
    }
}
