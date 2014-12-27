/*
   Program a simple regex matcher that takes a pattern and a string.

   The subset of patterns and strings is 'a', 'b', '.', '*'
   where '.' matches a or b, * is a modifier to the previous character so
   it may appear zero or more times

   match(pattern, string) -> bool

   match("ab*a", "a") -> false
   match("ab*a", "ab") -> false
   match("ab*a", "aba") -> true
   match("ab*a", "abba") -> true
   match("ab*a", "abbbba") -> true
   match(".a", "a") -> false
   match(".*", <anything>) -> true
*/

object Interview {
  def isMatch(regex: String, matchString: String) {
    println(matchRegex(regex, matchString, None))
  }

  def matchChar(regex: Char, char: Char) : Boolean = {
    regex == char || regex == '.'
  }

  def matchRegex(regex: String, matchString: String, prevChar: Option[Char]): Boolean = {
    if (matchString.length == 0 || regex.length == 0) {
      if (regex.length == 0 && matchString.length == 0) {
        return true
      } else {
        return false
      }
    }

    if (regex.head == '*') {
      if (prevChar.isEmpty) {
        return false
      }

      if (prevChar.get == '*') {
        return false
      }
    }

    if (matchChar(regex.head, matchString.head)) {
      matchRegex(regex.drop(1), matchString.drop(1), Some(regex.head))
    } else if (regex.head == '*') {
      if (matchChar(prevChar.get, matchString.head)) {
        matchRegex(regex, matchString.drop(1), prevChar)
      } else {
        matchRegex(regex.drop(1), matchString, Some(regex.head))
      }
    } else {
      //incorrect
      matchRegex(regex.drop(1), matchString, Some(regex.head))
    }
  }

  def main(args: Array[String]) {
    println("false ones")
    isMatch("ab*a", "a")
    isMatch("ab*a", "ab")
    isMatch(".a", "a")
    isMatch("..", "aba")
    isMatch("*ab", "aab")
    isMatch("a**", "aba")
    isMatch("abbba", "abba")

    println("\ntrue ones")
    isMatch("", "")
    isMatch("a", "a")
    isMatch("ab.", "aba")
    isMatch("...", "aba")
    isMatch("ab*a", "aba")
    isMatch("ab*a", "abba")
    isMatch("ab*a", "abbbba")
    isMatch("ab*a", "aa")
    isMatch("ab*ba", "aba")
    isMatch(".*", "ababababaabaa")
  }
}

