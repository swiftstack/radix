typealias EncodeTable = [UInt8]
private var table: EncodeTable = .init((
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
    "abcdefghijklmnopqrstuvwxyz" +
    "0123456789+/")
    .utf8)

extension Array where Element == UInt8 {
    public init(encodingToBase64 bytes: UnsafeBufferPointer<UInt8>) {
        var result = [UInt8]()
        for i in stride(from: 0, to: bytes.count, by: 3) {
            result.append((table[x3f: bytes[i] >> 2]))
            switch bytes.count {
            case i + 1:
                result.append(table[x3f: bytes[i] << 4])
                result.append(ascii: "=")
                result.append(ascii: "=")
            case i + 2:
                result.append(table[x3f: bytes[i] << 4 + (bytes[i + 1] >> 4)])
                result.append(table[x3f: bytes[i + 1] << 2])
                result.append(ascii: "=")
            default:
                result.append(table[x3f: bytes[i] << 4 + (bytes[i + 1] >> 4)])
                result.append(table[x3f: bytes[i + 1] << 2 + bytes[i + 2] >> 6])
                result.append(table[x3f: bytes[i + 2]])
            }
        }
        self = result
    }
}

extension Array where Element == UInt8 {
    @inlinable
    public init(encodingToBase64 string: String) {
        var string = string
        self = string.withUTF8 { .init(encodingToBase64: $0) }
    }

    @inlinable
    public init(encodingToBase64 bytes: [UInt8]) {
        self.init(encodingToBase64: bytes, count: bytes.count)
    }

    @inlinable // suppress warnings for UnsafeBufferPointer<UInt8>
    init(encodingToBase64 pointer: UnsafePointer<UInt8>, count: Int) {
        self.init(encodingToBase64: .init(start: pointer, count: count))
    }
}

// MARK: public api

extension String {
    @inlinable
    public init(encodingToBase64 string: String) {
        var string = string
        self = string.withUTF8 { .init(encodingToBase64: $0) }
    }

    @inlinable
    public init(encodingToBase64 buffer: UnsafeBufferPointer<UInt8>) {
        let result = [UInt8](encodingToBase64: buffer)
        self = String(decoding: result, as: UTF8.self)
    }

    @inlinable
    public init(encodingToBase64 bytes: [UInt8]) {
        self.init(encodingToBase64: bytes, count: bytes.count)
    }

    @inlinable // suppress warnings for UnsafeBufferPointer<UInt8>
    init(encodingToBase64 pointer: UnsafePointer<UInt8>, count: Int) {
        self.init(encodingToBase64: .init(start: pointer, count: count))
    }
}

// MARK: utils

private extension Array where Element == UInt8 {
    @inline(__always)
    subscript (x3f index: UInt8) -> UInt8 {
        return self[Int(index & 0x3f)]
    }

    @inline(__always)
    mutating func append(ascii scalar: Unicode.Scalar) {
        self.append(UInt8(ascii: scalar))
    }
}
