-------------------------------------
>@dump $assert with create

@create $generic_utils named assert:assert
    Note the obj # and set the "assert" prop in #0
@prop #0."assert" "#257"

@prop $assert."description" "A collection of assertion methods that raise a signal, including an "optional message, if they fail."
@prop $assert."message" "" rc
;;$assert.("unique_id") = 0
;;$assert.("aliases") = {"assert"}
;;$assert.("object_size") = {0, 0}
;;$assert.("last_recycled") = 1628664242
;;$assert.("last_modified") = 1628664308
;;$assert.("creation_date") = 1628664242

@verb $assert:"areEqual" this none this
@program $assert:areEqual
"$assert:areEqual(arg1, arg2, ?msg)";
"Asserts that two values are equal based on the == test";
"If not Equal, raise(E_NONE, msg)";
if (length(args) < 2)
  return raise(E_ARGS);
endif
msg = "";
{a, b, ?msg} = args;
if (a == b)
  return;
else
  raise(E_NONE, msg);
endif
.

@verb $assert:"isList" this none this
@program $assert:isList
"$assert:isList(arg,msg)";
"Asserts that the arg is a list.";
"If not, raise(E_NONE, msg)";
if (length(args) == 0)
  raise(E_ARGS);
endif
msg = "";
{value, ?msg} = args;
this:isTypeOf(value, LIST, msg);
.

@verb $assert:"isString" this none this
@program $assert:isString
"$assert:isString(arg,msg)";
"Asserts that arg is a string.";
"If not, raise(E_NONE, msg)";
if (length(args) == 0)
  raise(E_ARGS);
endif
msg = "";
{value, ?msg} = args;
this:isTypeOf(value, STR, msg);
.

@verb $assert:"isInt" this none this
@program $assert:isInt
"$assert:isInt(arg,msg)";
"Asserts that arg is an integer";
"If not, raise(E_NONE, msg)";
if (length(args) == 0)
  raise(E_ARGS);
endif
msg = "";
{value, ?msg} = args;
this:isTypeOf(value, INT, msg);
.

@verb $assert:"isFloat" this none this
@program $assert:isFloat
"$assert:isFloat(arg,msg)";
"Asserts that arg is a float";
"If not, raise(E_NONE, msg)";
if (length(args) == 0)
  raise(E_ARGS);
endif
msg = "";
{value, ?msg} = args;
this:isTypeOf(value, FLOAT, msg);
.

@verb $assert:"isObj" this none this
@program $assert:isObj
"$assert:isObj(arg,msg)";
"Asserts that arg is an object reference";
"If not, raise(E_NONE, msg)";
if (length(args) == 0)
  raise(E_ARGS);
endif
msg = "";
{value, ?msg} = args;
this:isTypeOf(value, OBJ, msg);
.

@verb $assert:"isErr" this none this
@program $assert:isErr
"$assert:isErr(arg,msg)";
"Asserts that arg is an error code";
"If not, raise(E_NONE, msg)";
if (length(args) == 0)
  raise(E_ARGS);
endif
msg = "";
{value, ?msg} = args;
this:isTypeOf(value, ERR, msg);
.

@verb $assert:"isTypeOf" this none this
@program $assert:isTypeOf
"$assert:isTypeOf(arg1,arg2,msg)";
"Asserts that arg1 is of the type given by arg2.";
"If not, raise(E_NONE, msg)";
if (length(args) < 2)
  raise(E_ARGS);
endif
msg = "";
{value, type, ?msg} = args;
if (typeof(value) == type)
  return;
else
  raise(E_NONE, msg);
endif
.

@verb $assert:"stringBeginsWith" this none this
@program $assert:stringBeginsWith
"$assert:stringBeginsWith(arg1,arg2,msg)";
"Asserts that the beginning of two strings is the same, until one or";
"the other string runs out of characters.";
"If not, raise(E_NONE, msg)";
if (length(args) < 2)
  raise(E_ARGS);
endif
index = 1;
msg = "";
{substring, fullstring, ?msg} = args;
$assert:isString(substring);
$assert:isString(fullstring);
while (((index <= length(substring)) && (index <= length(fullstring))) &&
(substring[index] == fullstring[index]))
  index = index + 1;
endwhile
"Stepped one too far.";
index = index - 1;
notify(player, tostr(index));
if ((index != length(substring)) && (index != length(fullstring)))
  raise(E_NONE, msg);
endif
.

;"***finished***"

-------------------------------------
>@dump $testHarness with create

@create $generic_utils named testHarness:testHarness
    Note the obj # and set the "testHarness" prop in #0
@prop #0."testHarness" "#256"

@prop $testHarness."description" "A Generic Test Harness that you should base your own test objects off of"
;;$testHarness.("unique_id") = 0
;;$testHarness.("aliases") = {"test_harness"}
;;$testHarness.("object_size") = {0, 0}
;;$testHarness.("last_recycled") = 1628663614
;;$testHarness.("last_modified") = 1628663904
;;$testHarness.("creation_date") = 1628663614

@verb $testHarness:setUp tnt
@program $testHarness:setUp
"Executed by the Runner before each test runs to set up the object for";
"tests.";
.

@verb $testHarness:tearDown tnt
@program $testHarness:tearDown
"Executed by the Runner after each test runs to restore the object to";
"an original state.";
.
;"***finished***"

-------------------------------------
>@dump $test_runner with create

@create $generic_utils named test_runner:test_runner
    Note the obj # and set the "test_runner" prop in #0
@prop #0."test_runner" "#258"

@prop $test_runner."description" "An object to run tests."
@prop $test_runner."testHarnesses" {} rc
;;$test_runner.("testHarnesses") = {}
;;$test_runner.("unique_id") = 0
;;$test_runner.("aliases") = {"test_runner"}
;;$test_runner.("object_size") = {0, 0}
;;$test_runner.("last_recycled") = 1628665506
;;$test_runner.("last_modified") = 1628665897
;;$test_runner.("creation_date") = 1628665506

@verb $test_runner:"addTestHarness" this none this
@program $test_runner:addTestHarness
"$test_runner:addTestHarness(obj)";
"Adds a test harness, obj, to the list of test harnesses to run.";
{harness} = args;
if ((typeof(harness) != OBJ) && (parent(harness) == $testHarness))
  raise(E_ARGS);
endif
this.testHarnesses = setadd(this.testHarnesses, harness);
.

@verb $test_runner:"runTests" this none this
@program $test_runner:runTests
"$test_runner:runTests()";
"$test_runner:runTests(obj)";
"Runs in two modes: With no arguments, will run all the test harnesses";
"added by the addTestHarness verb. Otherwise, you can send in a single";
"test harness to execute.";
results = {};
if (((length(args) == 1) && (typeof(args[1]) == OBJ)) && (parent(args[1]) ==
$testHarness))
  harness = args[1];
  for verb in (verbs(harness))
    if ((((verb[1] == "t") && (verb[2] == "e")) && (verb[3] == "s")) &&
(verb[4] == "t"))
      command = tostr(harness, ":", verb, "();");
      try
        harness:setUp();
        eval(command);
        results = listappend(results, {verb, "PASS"});
      except error (ANY)
        results = listappend(results, {verb, "FAIL", error[2]});
      endtry
      harness:tearDown();
    endif
  endfor
else
  for harness in (this.testHarnesses)
    results = listappend(results, {harness.name, this:runTests(harness)});
  endfor
endif
return results;
.

;"***finished***"

-------------------------------------
>@dump test_the_tests with create

@create $testHarness named test_the_tests:test_the_tests
    Note the obj # and change #259 below to the obj #.

@prop #259."description" "Unit tests for $assert, $testHarness, $test_runner."
;;#259.("aliases") = {"test_the_tests"}
;;#259.("last_recycled") = 1628665775
;;#259.("last_modified") = 1628666207
;;#259.("creation_date") = 1628665775

@verb #259:"testTypeValues" this none this
@program #259:testTypeValues
$assert:areEqual(typeof(""), STR);
$assert:areEqual(typeof({}), LIST);
$assert:areEqual(typeof(1), INT);
$assert:areEqual(typeof(1.0), FLOAT);
$assert:areEqual(typeof(#0), OBJ);
$assert:areEqual(typeof(E_NONE), ERR);
.

@verb #259:"test_toStr" this none this
@program #259:test_toStr
$assert:areEqual("17", tostr(17), "Integer -> String");
$assert:stringBeginsWith("0.333", tostr(1.0 / 3.0), "Division -> String");
$assert:areEqual("#17", tostr(#17), "ObjRef -> String");
$assert:areEqual("foo", tostr("foo"), "Identity");
$assert:areEqual("{list}", tostr({1, 2}), "List -> String");
$assert:areEqual("3 + 4 = 7", tostr("3 + 4 = ", 3 + 4), "Expression ->
String");
$assert:areEqual("abc", tostr("ab", "c"), "String Concatenation 2");
$assert:areEqual("abc de", tostr("ab", "c", " ", "de"), "String Concatenation
3");
.

@verb #259:"test_toLiteral" this none this
@program #259:test_toLiteral
$assert:areEqual("17", toliteral(17), "Integer -> Literal");
$assert:stringBeginsWith("0.333", toliteral(1.0 / 3.0), "Division -> Literal");
$assert:areEqual("#17", toliteral(#17), "ObjRef -> Literal");
$assert:areEqual("\"foo\"", toliteral("foo"), "String -> Literal");
$assert:areEqual("{1, 2}", toliteral({1, 2}), "List -> Literal");
.

@verb #259:"test_toInt" this none this
@program #259:test_toInt
$assert:areEqual(34, toint(34.7), "Float -> Int");
$assert:areEqual(-34, toint(-34.7), "Neg Float -> Int");
$assert:areEqual(34, toint(#34), "ObjRef -> Int");
$assert:areEqual(34, toint("34"), "String Int -> Int");
$assert:areEqual(34, toint("34.7"), "String Float -> Int");
$assert:areEqual(-34, toint("  -34.7  "), "String Neg Float -> Int");
.

@verb #259:"test_toObj" this none this
@program #259:test_toObj
$assert:areEqual(#34, toobj(34), "Int -> Obj");
$assert:areEqual(#34, toobj("34"), "String -> Obj");
$assert:areEqual(#34, toobj("#34"), "String-Hash -> Obj");
$assert:areEqual(#0, toobj("foo"), "Bad String-> Obj");
.

@verb #259:"test_toFloat" this none this
@program #259:test_toFloat
$assert:areEqual(1, equal("Foo", "Foo"), "Identical Strings");
$assert:areEqual(0, equal("foo", "Foo"), "Captilization Difference");
.

@verb #259:"test_equals" this none this
;"***finished***"
