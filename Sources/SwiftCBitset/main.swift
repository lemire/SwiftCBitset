import cbitset
import Swimsuit


func create() {
    let b1 = cbitset.bitset_create()!
    for k in stride(from: 0, to: 100000000, by: 100 ) {
       cbitset.bitset_set(b1,k)
    }
//    cbitset.bitset_free(b1)
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



var nano = Swimsuit.nanotime() {
}
print("Empty ", Double(nano) / 1_000_000.0, " ms")

nano = Swimsuit.nanotime() {
  create() 
}
print("testAddPerformance ", Double(nano) / 1_000_000.0, " ms")

let b1 = cbitset.bitset_create()!
var count = 0
for k in stride(from: 0, to: 100000000, by: 100 ) {
   cbitset.bitset_set(b1,k)
   count += 1
}


nano = Swimsuit.nanotime() {
  if cbitset.bitset_count(b1) != count {
    print("bug")
  }
}

print("testCountPerformance ", Double(nano) / 1_000_000.0, " ms")


nano = Swimsuit.nanotime() {
  if iterate(b1) != count {
    print("bug")
  }
}

print("testIteratePerformance ", Double(nano) / 1_000_000.0, " ms")

cbitset.bitset_free(b1)

print()
