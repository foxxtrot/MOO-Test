# Contrib

MOO-Test looks like it could be very a useful TDD tool for moo code,
but delivering the code in a Minimal.db makes it very hard to copy and
deploy the code to other MOOs, because there are no objects for
listing or dumping whole objects. However, this does prevent
dependencies on objects that are not in every core, but a careful
review could prevent that. Or a script could be written to flag any
non-builtin functions used in the objects.

Following OO development start with these base objects, then update
the verbs to include code that is specific to your MOO. Or keep the
code as-is and add other helper objects that use the MOO-Test objects.
For example, how about a $thing object that can help manage the
creation of test harnesses, running the tests, and logging the results
to $note objects that are saved with FUP.

## Process for getting the code

* Start up a lambda server with ConfirmationTests.db. Set it up with port 7777 on "localhost".

* telnet localhost 7777

* Using eval (;) get an outline of the objects and their verbs in the DB.
For example:

    ; properties(#0)
        => {"testHarness", "assert", "tnt", "test_runner"}
    ; #0.testHarness
        => #4
    ; #0.assert
        => #5
    ; verbs($assert)
        => {"areEqual", "isList", "isString", "isInt", "isFloat", "isObj",
            "isErr", "isTypeOf", "stringBeginsWith"}
    
    ; verb_code($assert,"areEqual")
        => {"if (length(args) < 2)", " return raise(E_ARGS);", "endif",
            "msg = \"\";", "{a, b, ?msg} = args;", "if (a == b)",
        "        return;", "else", " raise(E_NONE, msg);", "endif"}

Yes, this is tedious. The "Object Outline" has a summary of the results.

* After getting all the properties, with values, and verbs with code,
I created the objects in eduCore (which is very similar to
LambdaCore). I used $generic_utils as the parent object, but #1 could
have been used.

* Then "@dump" was used to get a pretty dump of the objects. The output
can be cut/pasted to create the objects.  Of course you will need to
adjust the object numbers for the created objects.

* Most MOO's have help functions that will list the strings at the
beginning of the verb. So I have copied the description text from the
main README.md file to be in the verbs, so they are self-documented.

### Object Outline

    System Object (#0)
        Parent => #1
        Properties => {"testHarness", "assert", "tnt", "test_runner"}
            #0.testHarness => #4
            #0.assert => #5
            #0.tnt => {"this", "none", "this"}  (not used)
            #0.test_runner => #7
        Verbs => {"do_login_command"}

    Root Class (#1)
        Parent => #-1
        Properties => none
        Verbs => none

    The First Room (#2)
        Parent => #1
        Properties => none
        Verbs => {"eval"}
           
    Wizard (#3)
        Parent => #1
        Properties => none
        Verbs => none

    $testHarness (#4)
        Parent => #1
        Properties =>  none
        Verbs => {"setUp", "tearDown"}
        
    $assert (#5)
        Parent => #1
        Properties => {"message"}
            #5.message => ""
        Verbs => {"areEqual", "isList", "isString", "isInt",
            "isFloat", "isObj", "isErr", "isTypeOf",
            "stringBeginsWith"}
        
    $test_runner (#7)
        Parent => #1
        Properties => {"testHarnesses"}
            #7.testHarnesses => {#6}
        Verbs => {"addTestHarness", "runTests"}    

    test_the_tests (#6)
        Parent => #4 ($testHarness)
        Properties =>  none
        Verbs => {"testTypeValues", "test_toStr", "test_toLiteral",
            "test_toInt", "test_toObj", "test_toFloat", "test_equals"}

## Install the Code

See: file unit-test-obj.moo and follow the directions in the
file. Mainly you will create the util objects and define them in a #0
property, so those names can be use to define all of the object's
properties and verbs.

After importing the code, you can test it with the "test_the_tests" object.

## Test the Install

List the objects just created. (Of course, you'll find them a better home.)

    >inv
    Carrying:
     testHarness                             test_runner
     assert                                  test_the_tests

Add "test_the_tests" object (#259):

    >; $test_runner:addTestHarness(#259)

Run the tests:

    >; $test_runner:runTests()
    5
    5
    => {{"test_the_tests", {{"testTypeValues", "PASS"}, {"test_toStr",
        "PASS"}, {"test_toLiteral", "PASS"}, {"test_toInt", "PASS"},
        {"test_toObj", "PASS"}, {"test_toFloat", "PASS"},
        {"test_equals", "PASS"}}}}
