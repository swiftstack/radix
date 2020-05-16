import Test
@testable import Hex

class HexTests: TestCase {
    func testEncode() {
        let bytes: [UInt8] = [192, 1]
        expect(String(encodingToHex: bytes) == "c001")
        expect(String(encodingToHex: bytes, format: .uppercase) == "C001")

        expect(String(encodingToHex: [], format: .array) == "[]")
        expect(String(encodingToHex: bytes, format: .array) == "[0xc0, 0x01]")
        expect(
            String(encodingToHex: bytes, format: [.uppercase, .array])
            ==
            "[0xC0, 0x01]")
    }

    func testDecode() {
        let expected: [UInt8] = [192, 1]
        expect([UInt8](decodingHex: "c001") == expected)
        expect([UInt8](decodingHex: "C001") == expected)
    }
}
