import Foundation
import CoreData

@objc(PokemonEntryCoreData)
public class PokemonEntryCoreData: NSManagedObject {}

extension PokemonEntryCoreData
{
    @NSManaged public var id: String?
    @NSManaged public var url: String?
    @NSManaged public var name: String?
    @NSManaged public var image: Data?
    @NSManaged public var type: String?
    @NSManaged public var genus: String?
}

extension PokemonEntryCoreData : Identifiable {}
