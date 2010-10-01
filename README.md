MOO Tests
=========

There is a *lot* of MOO Code out there, much of it in use on many Text games,
however, I have seen little effort inside the MOO community to ensure
correctness in their programming, which can lead to situations where
a large number of tracebacks can be triggered by a small programming
error.

MOO Tests attempts to add a unit test framework that can run in any MOO,
regardless of the Core DB used as the basis for the DB. The current DB
file, which will contain confirmation tests to validate the correctness
of a server implementation, is based on the Minimal.db that ships with
LambdaMOO server.

Objects
-------

$assert - A collection of assertion methods that raise a signal, including an optional message, if they fail.
- areEqual - Asserts that two values are equal based on the == test
- isList - Asserts that the argument is a list
- isString - Asserts that the argument is a string
- isInt - Asserts that the argument is an integer
- isFloat - Asserts that the argument is a float
- isObj - Asserts that the argument is an object reference
- isErr - Asserts that the argument is an error code
- isTypeOf - Asserts that the first argument is of the type given by the second argument
- stringBeginsWith - Asserts that the beginning of two strings is the same, until one or the other string runs out of characters.

$testHarness - A Generic Test Harness that you should base your own test objects off of
- setUp - Executed by the Runner before each test runs to set up the object for tests.
- tearDown - Executed by the Runner after each test runs to restore the object to an original state.

$test_runner - An object to run tests
- addTestHarness - Adds a test harness to the list of test harnesses to run
- runTests - Runs in two modes: With no arguments, will run all the test harnesses added by the addTestHarness verb. Otherwise, you can send in a single test harness to execute.

TODO
----
- Add test harnesses for the rest of the builtin methods defined by MOO
- Add formatting methods to display pretty output
- Investigate using FUP to output a JSON object of the results
- Add Unit Tests to work test framework.
