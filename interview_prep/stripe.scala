import scala.collection.mutable

object Interview {
  def main(args: Array[String]) {
    val nameMap = mutable.Map("api" -> List(1, 2, 3), "web" -> List(2, 7, 3))

    println(assign_server_name("api", nameMap)) //api1
    println(assign_server_name("api", nameMap)) //api2
    println(assign_server_name("test", nameMap)) //api2
  }

  def returnSmallest(numList: List[Int]): Int = {
    //create hash table from numList
    val hashList = numList.toSet
    var i = 0

    while (i < hashList.size && hashList.contains(i + 1)) {
      i = i + 1
    }

    i + 1
  }

  def assign_server_name(name: String, nameMap: mutable.Map[String, List[Int]]) : String = {
    val nameServerNums = if (nameMap.contains(name)) { nameMap(name) } else { List() }

    val smallest = returnSmallest(nameServerNums)
    nameMap(name) = nameServerNums ++ List(smallest)

    name + smallest
  }
}
