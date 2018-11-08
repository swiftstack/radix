import Test
@testable import Hex

class HexTests: TestCase {
    func testEncode() {
        let bytes: [UInt8] = [192, 1]
        assertEqual(String(encodingToHex: bytes), "c001")
        assertEqual(String(encodingToHex: bytes, uppercase: true), "C001")
    }

    func testDecode() {
        let expected: [UInt8] = [192, 1]
        assertEqual([UInt8](decodingHex: "c001"), expected)
        assertEqual([UInt8](decodingHex: "C001"), expected)
    }
}
