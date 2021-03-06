import cbitset
import Swimsuit

final class Bitset { 
        let ptr : UnsafeMutablePointer<bitset_s> 
        init(bitset : Bitset) { self.ptr = cbitset.bitset_copy(bitset.ptr)!}
        init() { self.ptr = cbitset.bitset_create()! } 
        deinit { cbitset.bitset_free(self.ptr) } 
        func set(_ i : Int) { cbitset.bitset_set(ptr,i) } 
        func get(_ i : Int) -> Bool { return cbitset.bitset_get(ptr,i) } 
        func next(_ i : inout Int) -> Bool {
          return cbitset.nextSetBit(self.ptr,&i)
        }
        func count() -> Int {
          return cbitset.bitset_count(self.ptr);
        }
} 

func create() {
    let b1 = cbitset.bitset_create()!
    for k in stride(from: 0, to: 100000000, by: 100 ) {
       cbitset.bitset_set(b1,k)
    }
    cbitset.bitset_free(b1)
}

func createBitset() {
    let b1 = Bitset()
    for k in stride(from: 0, to: 100000000, by: 100 ) {
       b1.set(k)
    }
}



func iterate(_ b1 : UnsafeMutablePointer<bitset_s>) -> Int {
  var sum = 0
  var i : cbitset.size_t = 0
  while cbitset.nextSetBit(b1,&i) {
    i = i &+ 1
    sum = sum &+ 1
  }
  return sum;
}

func iterate(_ b1 : Bitset) -> Int {
  var sum = 0
  var i  = 0
  while b1.next(&i) {
    i = i &+ 1
    sum = sum &+ 1
  }
  return sum;
}



var nano = Swimsuit.nanotime() {
}
print("Empty ", Double(nano) / 1_000_000.0, " ms")

nano = Swimsuit.nanotime() {
  create() 
}
print("testAddPerformance ", Double(nano) / 1_000_000.0, " ms")

nano = Swimsuit.nanotime() {
  create() 
}
print("testAddPerformance (Bitset) ", Double(nano) / 1_000_000.0, " ms")


let b1 = cbitset.bitset_create()!
var count = 0
for k in stride(from: 0, to: 100000000, by: 100 ) {
   cbitset.bitset_set(b1,k)
   count += 1
}

let c1 = Bitset()
for k in stride(from: 0, to: 100000000, by: 100 ) {
   c1.set(k)
}

nano = Swimsuit.nanotime() {
  if cbitset.bitset_count(b1) != count {
    print("bug")
  }
}

print("testCountPerformance ", Double(nano) / 1_000_000.0, " ms")

nano = Swimsuit.nanotime() {
  if c1.count() != count {
    print("bug")
  }
}

print("testCountPerformance (bitset) ", Double(nano) / 1_000_000.0, " ms")


nano = Swimsuit.nanotime() {
  if iterate(b1) != count {
    print("bug")
  }
}

print("testIteratePerformance ", Double(nano) / 1_000_000.0, " ms")

nano = Swimsuit.nanotime() {
  if iterate(c1) != count {
    print("bug")
  }
}

print("testIteratePerformance (bitset) ", Double(nano) / 1_000_000.0, " ms")


cbitset.bitset_free(b1)

print()
