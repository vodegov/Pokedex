import UIKit

final class MovesCollectionViewCell: UICollectionViewCell
{
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = Constants.Fonts.nameMoveText
        
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String) {
        self.nameLabel.text = name.capitalized
    }
}

private extension MovesCollectionViewCell
{
    func buildUI() {
        self.backgroundColor = .clear
        
        self.contentView.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview()
                .inset(Constants.Layout.horizontalSpace)
        }
    }
}
