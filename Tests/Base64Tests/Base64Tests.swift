import Test
@testable import Base64

class Base64Tests: TestCase {
    func testEncode() {
        assertEqual(String(encodingToBase64: "swiftstack"), "c3dpZnRzdGFjaw==")
        assertEqual(String(encodingToBase64: "swiftstack."), "c3dpZnRzdGFjay4=")
        assertEqual(String(encodingToBase64: "swiftstack.."), "c3dpZnRzdGFjay4u")
    }

    func testDecode() {
        assertEqual(String(decodingBase64: "c3dpZnRzdGFjaw=="), "swiftstack")
        assertEqual(String(decodingBase64: "c3dpZnRzdGFjay4="), "swiftstack.")
        assertEqual(String(decodingBase64: "c3dpZnRzdGFjay4u"), "swiftstack..")
    }
}
