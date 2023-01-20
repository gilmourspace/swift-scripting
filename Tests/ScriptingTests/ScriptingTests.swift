import XCTest
@testable import Scripting

final class ScriptingTests: XCTestCase {
    func testPathSearch() {
        let result = search(for: "ls", in: "/bin")
#if os(Linux)
        XCTAssertEqual(result?.path, "/bin/ls")
#else
        if #available(macOS 13.0, *) {
            XCTAssertEqual(result?.path(percentEncoded: false), "/bin/ls")
        } else {
            XCTAssertEqual(result?.path, "/bin/ls")
        }
#endif
    }

    func testHello() async throws {
        var string = ""
        await ShellCommand("/bin/echo", arguments: ["hello"]) > string
        XCTAssertEqual(string, "hello\n")
    }
}
