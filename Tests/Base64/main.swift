import Test
@testable import Base64

// MARK: Correctness

test.case("encode string to string") {
    expect(String(encodingToBase64: "swiftstack") == "c3dpZnRzdGFjaw==")
    expect(String(encodingToBase64: "swiftstack.") == "c3dpZnRzdGFjay4=")
    expect(String(encodingToBase64: "swiftstack..") == "c3dpZnRzdGFjay4u")
}

test.case("decode string to string") {
    expect(String(decodingBase64: "c3dpZnRzdGFjaw==") == "swiftstack")
    expect(String(decodingBase64: "c3dpZnRzdGFjay4=") == "swiftstack.")
    expect(String(decodingBase64: "c3dpZnRzdGFjay4u") == "swiftstack..")
}

// MARK: Convenience API

let decodedString: String = "swiftstack"
let decodedBytes: [UInt8] = .init(decodedString.utf8)
let encodedString: String = "c3dpZnRzdGFjaw=="
let encodedBytes: [UInt8] = .init(encodedString.utf8)

test.case("encode string to bytes") {
    expect([UInt8](encodingToBase64: decodedString) == encodedBytes)
}

test.case("decode string to bytes") {
    expect([UInt8](decodingBase64: encodedString) == decodedBytes)
}

test.case("encode bytes to string") {
    expect(String(encodingToBase64: decodedBytes) == encodedString)
}

test.case("decode bytes to string") {
    expect(String(decodingBase64: encodedBytes) == decodedString)
}

test.case("encode bytes to bytes") {
    expect([UInt8](encodingToBase64: decodedBytes) == encodedBytes)
}

test.case("decode bytes to bytes") {
    expect([UInt8](decodingBase64: encodedBytes) == decodedBytes)
}

test.run()
