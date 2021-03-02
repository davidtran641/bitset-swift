import Foundation

/// An implementation of BitSet
struct BitSet {

  private enum Constants {
    /// Number of bit per word. Currently we use Int64, so it's 6 bits
    static let addressBitsPerWord: Int = 6

    /// Magic number to quick have last 6 bits
    static let addressBitsMask: Int = (1 << addressBitsPerWord) - 1 // 0x3F
  }

  /// Data store of words
  private var words: [UInt64]
  
  /// Current word capacity
  private var currentWordCapacity: Int = 0
  
  /// Init with desired capacity
  init(capacity: Int = 0) {
    currentWordCapacity = ((capacity-1) >> Constants.addressBitsPerWord) + 1
    words = [UInt64](repeating: 0, count: currentWordCapacity)
  }

  /// Set value of a specified index to true
  mutating func setBit(at bitIndex: Int) {
    guard bitIndex >= 0 else { return }
    let idx = wordIndex(bitIndex: bitIndex)
    let m = mask(bitIndex: bitIndex)

    ensureWordCapacity(wordIndex: idx)
    words[idx] |= m
  }

  /// Get the value of a specified index
  func getBit(at bitIndex: Int) -> Bool {
    guard bitIndex >= 0 else { return false }

    let idx = wordIndex(bitIndex: bitIndex)
    guard idx < currentWordCapacity else { return false }


    let m = mask(bitIndex: bitIndex)

    return (self.words[idx] & m) != 0
  }

  /// Clear value of a specified index
  mutating func clearBit(at bitIndex: Int) {
    guard bitIndex >= 0 else { return }
    let idx = wordIndex(bitIndex: bitIndex)

    guard idx < currentWordCapacity else { return }

    let m = mask(bitIndex: bitIndex)
    words[idx] &= (~m)
  }

  /// Check and increase the size of words if needed to be able to store the value at a specified word index
  private mutating func ensureWordCapacity(wordIndex: Int) {
    let targetCapacity = wordIndex + 1
    if currentWordCapacity < targetCapacity { 
      
      words.reserveCapacity(targetCapacity)
      for _ in currentWordCapacity..<targetCapacity {
        words.append(0)
      }

      currentWordCapacity = targetCapacity
    }
  }

  /// Return the word index containing the value of a specified bit index
  private func wordIndex(bitIndex: Int) -> Int {
    return bitIndex >> Constants.addressBitsPerWord
  }

  private func mask(bitIndex: Int) -> UInt64 {
    return UInt64(1) << (bitIndex & Constants.addressBitsMask) 
  }

  /// Convert to string
  func toString() -> String {
    return words.map { String($0, radix: 2) }.joined(separator: "-")
  }

}
