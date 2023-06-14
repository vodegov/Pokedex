import UIKit

final class SegmentControlTableViewCell: UITableViewCell
{
    private var segmentControll: UISegmentedControl!
    private let arraySegments = ["About", "Stats", "Moves", "Evolutions"]
    var segmentControllHandler: ((Int) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func segmentControllChanged() {
        let index = self.segmentControll.selectedSegmentIndex
        segmentControllHandler?(index)
    }

}

private extension SegmentControlTableViewCell
{
    func configure() {
        self.segmentControll = UISegmentedControl(items: arraySegments)
        self.segmentControll.selectedSegmentIndex = 0
        self.segmentControll.isSpringLoaded = true
        self.segmentControll.addTarget(self, action: #selector(segmentControllChanged), for: .valueChanged)
        buildUI()
    }
    
    func buildUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.addSubview(segmentControll)
        self.segmentControll.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
