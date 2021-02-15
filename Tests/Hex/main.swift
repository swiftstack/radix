import Test
@testable import Hex

let bytes: [UInt8] = [192, 1]

test.case("encode to hex") {
    expect(String(encodingToHex: bytes) == "c001")
}

test.case("encode to hex uppercased") {
    expect(String(encodingToHex: bytes, format: .uppercase) == "C001")
}

test.case("encode to hex array") {
    expect(String(encodingToHex: [], format: .array) == "[]")
    expect(String(encodingToHex: bytes, format: .array) == "[0xc0, 0x01]")
}

test.case("encode to hex uppercased array") {
    let result = String(encodingToHex: bytes, format: [.uppercase, .array])
    expect(result == "[0xC0, 0x01]")
}

test.case("decode from hex") {
    expect([UInt8](decodingHex: "c001") == bytes)
}

test.case("decode from hex uppercased") {
    expect([UInt8](decodingHex: "C001") == bytes)
}

test.run()
