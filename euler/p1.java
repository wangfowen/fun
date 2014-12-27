 //Find the sum of all the multiples of 3 or 5 below 1000.

class P1 {
  final static int THRESHOLD = 999;

  private static int arithmeticSum(int n) {
    return (n * (n + 1)) / 2;
  }

  private static int sumMultiplesOf(int n) {
    return n * arithmeticSum(THRESHOLD / n);
  }

  public static void main(String []args) {
    int solution = sumMultiplesOf(3) + sumMultiplesOf(5) - sumMultiplesOf(15);

    System.out.println(solution);
  }
}
