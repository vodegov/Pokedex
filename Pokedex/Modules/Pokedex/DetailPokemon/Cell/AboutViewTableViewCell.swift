import UIKit

final class AboutViewTableViewCell: UITableViewCell
{
    private lazy var aboutLabel: UILabel = {
        let aboutLabel = UILabel()
        aboutLabel.numberOfLines = 0
        aboutLabel.textColor = Constants.Colors.aboutPokemonText
        aboutLabel.font = Constants.Fonts.aboutPokemonText
        
        return aboutLabel
    }()
    private lazy var viewForInfo: UIView = {
        let viewForInfo = UIView()
        viewForInfo.layer.cornerRadius = Layout.radiusViewInfo
        viewForInfo.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1254901961, blue: 0.1333333333, alpha: 1)
        viewForInfo.layer.opacity = 0.7
        
        return viewForInfo
    }()
    
    private let weightLabel = UILabel()
    private let heightLabel = UILabel()
    private let experienceLabel = UILabel()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.buildUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(about: String, weight: Int, height: Int, experience: Int) {
        self.aboutLabel.text = about
        let doubleHeight = Double(height)
        let doubleWeight = Double(weight)
        self.weightLabel.text = "\(doubleWeight / 10)kg"
        self.heightLabel.text = "\(doubleHeight / 10)m"
        self.experienceLabel.text = "\(experience)"
    }
}

private extension AboutViewTableViewCell
{
    func buildUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.addSubview(self.aboutLabel)
        self.aboutLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .inset(Constants.Layout.verticalSpace)
            make.horizontalEdges.equalToSuperview()
                .inset(Constants.Layout.horizontalSpace)
        }
        
        self.contentView.addSubview(viewForInfo)
        self.viewForInfo.snp.makeConstraints { make in
            make.top.equalTo(self.aboutLabel.snp.bottom)
                .inset(-Layout.verticalSpace)
            make.horizontalEdges.equalToSuperview()
                .inset(Constants.Layout.horizontalSpace)
            make.height.equalTo(Layout.heightViewForInfo)
            make.bottom.equalToSuperview()
                .inset(Layout.verticalSpace)
        }
        
        let lineSeparatorTop = UIView()
        self.viewForInfo.addSubview(lineSeparatorTop)
        lineSeparatorTop.backgroundColor = .darkGray
        lineSeparatorTop.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
                .inset(25)
            make.height.equalTo(50)
            make.width.equalTo(2)
        }
        
        let lineSeparatorBottom = UIView()
        self.viewForInfo.addSubview(lineSeparatorBottom)
        lineSeparatorBottom.backgroundColor = .darkGray
        lineSeparatorBottom.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
                .inset(25)
            make.height.equalTo(50)
            make.width.equalTo(2)
        }
        
        let weightConteiner = UIView()
        self.viewForInfo.addSubview(weightConteiner)
        weightConteiner.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .inset(24)
            make.leading.equalToSuperview()
                .inset(42)
        }
        let weightImage = UIImageView()
        weightImage.image = UIImage(named: "weight")
        weightConteiner.addSubview(weightImage)
        weightImage.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
        }
        
        weightConteiner.addSubview(weightLabel)
        self.weightLabel.textColor = .white
        self.weightLabel.text = "85.5kg"
        self.weightLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(weightImage.snp.trailing)
                .inset(-8)
            make.trailing.equalToSuperview()
        }
        
        let weightNameLabel = UILabel()
        weightNameLabel.textColor = .darkGray
        weightNameLabel.text = "Weight"
        self.viewForInfo.addSubview(weightNameLabel)
        weightNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(weightConteiner)
            make.top.equalTo(weightConteiner.snp.bottom)
                .inset(-8)
        }
        
        let heightConteiner = UIView()
        self.viewForInfo.addSubview(heightConteiner)
        heightConteiner.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .inset(24)
            make.trailing.equalToSuperview()
                .inset(58)
        }
        let heightImage = UIImageView()
        heightImage.image = UIImage(systemName: "arrow.up")
        heightImage.tintColor = .lightGray
        heightConteiner.addSubview(heightImage)
        heightImage.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
        }
        
        heightConteiner.addSubview(self.heightLabel)
        self.heightLabel.textColor = .white
        self.heightLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(heightImage.snp.trailing)
                .inset(-8)
            make.trailing.equalToSuperview()
        }
        
        let heightNameLabel = UILabel()
        heightNameLabel.textColor = .darkGray
        heightNameLabel.text = "Height"
        self.viewForInfo.addSubview(heightNameLabel)
        heightNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(heightConteiner)
            make.top.equalTo(heightConteiner.snp.bottom)
                .inset(-8)
        }
        
        let experienceConteiner = UIView()
        self.viewForInfo.addSubview(experienceConteiner)
        experienceConteiner.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
                .inset(64)
            make.leading.equalToSuperview()
                .inset(42)
        }
        
        let experienceImage = UIImageView()
        experienceImage.image = UIImage(systemName: "graduationcap")
        experienceImage.tintColor = .lightGray
        experienceConteiner.addSubview(experienceImage)
        experienceImage.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
        }
        
        experienceConteiner.addSubview(self.experienceLabel)
        self.experienceLabel.textColor = .white
        self.experienceLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(experienceImage.snp.trailing)
                .inset(-8)
            make.trailing.equalToSuperview()
        }
        
        let experienceNameLabel = UILabel()
        experienceNameLabel.textColor = .darkGray
        experienceNameLabel.text = "Experience"
        self.viewForInfo.addSubview(experienceNameLabel)
        experienceNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(experienceConteiner)
            make.top.equalTo(experienceConteiner.snp.bottom)
                .inset(-8)
        }

    }
}

fileprivate enum Layout
{
    static let radiusViewInfo: CGFloat = 8
    static let verticalSpace: CGFloat = 32
    static let heightViewForInfo: CGFloat = 200
}
