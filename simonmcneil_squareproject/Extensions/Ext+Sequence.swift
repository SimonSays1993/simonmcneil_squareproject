import Foundation

extension Sequence {
    func sortedByKeyPath<T: Comparable>(by keyPath: KeyPath<Element, T>, using comparator: (T, T) -> Bool = (<)) -> [Element] {
        sorted { a, b in
            comparator(a[keyPath: keyPath], b[keyPath: keyPath])
        }
    }
}
