typealias DecodeTable = [Int8]
private let table: DecodeTable = [
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
     0,  1,  2,  3,  4,  5,  6,  7,  8,  9, -1, -1, -1, -1, -1, -1,
    -1, 10, 11, 12, 13, 14, 15, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, 10, 11, 12, 13, 14, 15, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]

extension Array where Element == UInt8 {
    public init?(decodingHex bytes: UnsafeRawBufferPointer) {
        guard bytes.count.isEven else {
            return nil
        }
        var result = [UInt8](repeating: 0, count: bytes.count.half)
        for i in stride(from: 0, to: bytes.count, by: 2) {
            let high = table[Int(bytes[i])]
            let low = table[Int(bytes[i + 1])]
            guard high != -1, low != -1 else {
                return nil
            }
            result[i.half] = UInt8(high) << 4 | UInt8(low)
        }
        self = result
    }

    public init?(decodingHex string: String) {
        let count = string.utf8.count
        let result = string.withCString { Self(decodingHex: $0, count: count) }
        guard let array = result else { return nil }
        self = array
    }

    // suppress warnings for UnsafeRawBufferPointer
    private init?(decodingHex bytes: UnsafePointer<Int8>, count: Int) {
        self.init(decodingHex: .init(start: bytes, count: count))
    }
}
