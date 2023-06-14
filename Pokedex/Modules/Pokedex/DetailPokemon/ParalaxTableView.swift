import UIKit

final class ParalaxTableView: UITableView
{
    private var heightConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let header = tableHeaderView else { return }
        if self.heightConstraint == nil {
            if let imageView = header.subviews.first as? UIImageView {
                self.heightConstraint = imageView.constraints.filter{ $0.identifier == "height" }.first
                self.bottomConstraint = header.constraints.filter{ $0.identifier == "bottom" }.first
            }
        }
        
        let offsetY = -contentOffset.y
        self.heightConstraint?.constant = max(header.bounds.height - 50, header.bounds.height + offsetY)
        self.bottomConstraint?.constant = offsetY >= 0
        ? 0
        : offsetY / 20
        header.clipsToBounds = offsetY <= 0
    }
}
