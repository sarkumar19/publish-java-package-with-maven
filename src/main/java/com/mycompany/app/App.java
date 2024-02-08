public class Main {

    // Introduce improper naming convention
    private static int x = 10;

    public static void main(String[] args) {
        // Introduce unused variable
        int y = 20;

        // Introduce unnecessary complex code
        if (x == 10) {
            System.out.println("x is 10");
        } else if (x == 20) {
            System.out.println("x is 20");
        } else {
            System.out.println("x is neither 10 nor 20");
        }

        // Introduce catching exception without logging or handling
        try {
            int result = divide(10, 0);
            System.out.println("Result: " + result);
        } catch (ArithmeticException e) {
            // Intentionally empty catch block
        }

        // Introduce SQL injection vulnerability
        String username = "admin'; DROP TABLE users;";
        String query = "SELECT * FROM users WHERE username='" + username + "'";
        System.out.println("Executing query: " + query);

        // Introduce assertion that always fails
        assert false : "This assertion always fails";

        // Introduce concurrency issue (race condition)
        Counter counter = new Counter();
        Thread incrementThread = new Thread(() -> {
            for (int i = 0; i < 1000; i++) {
                counter.increment();
            }
        });
        Thread decrementThread = new Thread(() -> {
            for (int i = 0; i < 1000; i++) {
                counter.decrement();
            }
        });
        incrementThread.start();
        decrementThread.start();
        try {
            incrementThread.join();
            decrementThread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        // Introduce resource leak
        try {
            FileWriter writer = new FileWriter("output.txt");
            writer.write("Hello, World!");
            // Missing writer.close() to intentionally leak the resource
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static int divide(int dividend, int divisor) {
        return dividend / divisor;
    }
}

class Counter {
    private int count;

    public void increment() {
        count++;
    }

    public void decrement() {
        count--;
    }
}
