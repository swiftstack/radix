import Test
@testable import Base64

test.case("Encode") {
    expect(String(encodingToBase64: "swiftstack") == "c3dpZnRzdGFjaw==")
    expect(String(encodingToBase64: "swiftstack.") == "c3dpZnRzdGFjay4=")
    expect(String(encodingToBase64: "swiftstack..") == "c3dpZnRzdGFjay4u")
}

test.case("Decode") {
    expect(String(decodingBase64: "c3dpZnRzdGFjaw==") == "swiftstack")
    expect(String(decodingBase64: "c3dpZnRzdGFjay4=") == "swiftstack.")
    expect(String(decodingBase64: "c3dpZnRzdGFjay4u") == "swiftstack..")
}

test.run()
