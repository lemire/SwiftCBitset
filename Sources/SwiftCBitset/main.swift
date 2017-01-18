import cbitset
import Swimsuit


func create() {
    let b1 = cbitset.bitset_create()
    // that's not the swift way, but whatever
    var k : cbitset.size_t = 0
    let maxk : cbitset.size_t = 100000000
    while k < maxk {
      cbitset.bitset_set(b1,k)
      k+=100
    }
    cbitset.bitset_free(b1)
}

func iterate(_ b1 : UnsafeMutablePointer<bitset_s>) -> Int {
  var sum = 0
  var i : cbitset.size_t = 0
  while cbitset.nextSetBit(b1,&i) {
    i += 1
    sum += 1
  }
  return sum;
}


for _ in 0...10 {

var nano = Swimsuit.nanotime() {
  create()
}
print("testAddPerformance ", Double(nano) / 1_000_000.0, " ms")

    let b1 = cbitset.bitset_create()
    // that's not the swift way, but whatever
    var k : cbitset.size_t = 0
    let maxk : cbitset.size_t = 100000000
    while k < maxk {
      cbitset.bitset_set(b1,k)
      k+=100
    }




nano = Swimsuit.nanotime() {
  cbitset.bitset_count(b1!)
}
print("testCountPerformance ", Double(nano) / 1_000_000.0, " ms")


nano = Swimsuit.nanotime() {
  iterate(b1!)
}
print("testIteratePerformance ", Double(nano) / 1_000_000.0, " ms")

cbitset.bitset_free(b1)

print()

}
