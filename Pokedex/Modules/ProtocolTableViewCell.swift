import UIKit

protocol ITableViewCell: AnyObject
{
    associatedtype Model
    func configure(model: Model)
}
