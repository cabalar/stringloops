# stringloops

*stringloops* contains a formalisation of scenarios involving holed
 objects, strings and string loops treated as holes. The formalisation
 is encoded in the input language of tool
 [telingo](https://github.com/potassco/telingo), an extension of the
 popular *Answer Set Programming* solver *clingo* with the addition of
 modal temporal operators.

## Installation and usage

The examples can be tested by directly using
[telingo](https://github.com/potassco/telingo). For instance, to solve
the puzzle known as *Fisherman's Folly*, run

```
telingo objtheory.pl ex/fisherman.pl
```

This will show executed actions through predicate `o(A)` (action `A`
has occurred) and all the fluent values at each state through
predicate `h(F,V)` (fluent `F` holds value `V`).

For a better illustration, the package includes a Prolog
program, `display.lp` that prints the chain of crossings of each string
at each state along the trace. This program requires the previous
installation of the Prolog
interpreter [SWI-prolog](https://www.swi-prolog.org/). As an example
of its usage, run `swipl -f display.pl` and then perform the query
```
?- solve('ex/fisherman.pl','objtheory.pl').
```
The first argument is the scenario file (in this case, the Fisherman's
Folly) and the second is the theory we use (see next section). The
execution of this query will display, in each step, the performed actions plus chains like
```
chain(s) = --0-> s1,p --1-> ph,p --2-> s2,p --3->
chain(post) = --4-> ring,p --5->
```
that correspond to the sequences of segments (displayed as numbered arrows) and
hole crossings of each string.

## Available theories

The package contains two different available theories:
- *objtheory*: this theory models actions at a higher level, so it only
considers passing elements through holes. These elements can be string
tips, objects linked to them, or simple holed objects, like a ring for
instance. Each passing action pulls from the string so that no loop is
ever created.

- *looptheory*: this is a more fine grained theory where string loops
  can be created by including two basic operations on string segments:
  *picking* and *pulling*. These actions may create or destroy string
  loops that, in their turn, may behave as holes crossed by other
  string segments. To try a pair of examples for this theory, run the
  prolog queries
  ```
  ?- solve('ex/african.pl').
  ?- solve('ex/edi.pl').
  ```
that respectively show the solutions for the African Ring and
  Easy-does-it puzzles. Predicate `solve(E)` with one argument is
  equivalent to `solve(E,'looptheory.pl')`.
