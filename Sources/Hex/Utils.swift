extension BinaryInteger {
    var isEven: Bool {
        @inline(__always)
        get { return self & 1 == 0 }
    }

    var twice: Self {
        @inline(__always)
        get { return self << 1 }
    }

    var half: Self {
        @inline(__always)
        get { return self >> 1 }
    }
}
