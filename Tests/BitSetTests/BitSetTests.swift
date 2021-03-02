
import XCTest
@testable import BitSetLib

final class BitSetTests: XCTestCase {

  private var bitSet: BitSet!

  override func setUp() {
    super.setUp()
    bitSet = BitSet()
  }

  override func tearDown() {
    bitSet = nil
    super.tearDown()
  }

  func testGetBitEmpty() {
    XCTAssertEqual(bitSet.getBit(at: 0), false)
  }

  func testGetBit() {
    bitSet.setBit(at: 101)

    XCTAssertEqual(bitSet.getBit(at: 1), false)
    XCTAssertEqual(bitSet.getBit(at: 0), false)
    XCTAssertEqual(bitSet.getBit(at: 101), true)
  }

  func testSetBitMultiple() {
    bitSet.setBit(at: 101)
    bitSet.setBit(at: 103)

    XCTAssertEqual(bitSet.getBit(at: 101), true)
    XCTAssertEqual(bitSet.getBit(at: 102), false)
    XCTAssertEqual(bitSet.getBit(at: 103), true)
  }

  func testClearBit() {
    bitSet.setBit(at: 101)

    XCTAssertEqual(bitSet.getBit(at: 101), true)

    bitSet.clearBit(at: 101)

    XCTAssertEqual(bitSet.getBit(at: 101), false)
  }

  func testToString() {
    bitSet.setBit(at: 1)
    bitSet.setBit(at: 66)
    bitSet.setBit(at: 68)

    XCTAssertEqual(bitSet.toString(), "10-10100")
  }
}
