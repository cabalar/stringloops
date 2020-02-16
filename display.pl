:- ['solutions.pl'].

solve(F,Theory) :-
   telingo([Theory,F],1),
   answer(0,Ss),!,
   repeat, (member(S,Ss),printstate(S),nl,fail;!).

solve(F) :-
   solve(F,'looptheory.pl').

printstate(S) :-
    write('Next state: '),
    printactions(S),nl,
    %    printfacts(S),nl,
    printchains(S),
    member(loop(X,Y),S),
    write(l(X,Y)),nl,
    fail.
printstate(_).

printchains(S) :- 
   member(h(start(C),X),S),
   write(chain(C)),write(' = '),
   printchain(S,X),nl,
   fail.
printchains(_).

printactions(S) :-
    member(o(A),S), write(A), write(' '), fail.
printactions(_).

printchain(S,X) :-
   write('--'),write(X),write('->'),
   (member(h(next(X),Y),S),!,
      (member(h(cross(X),f(H,D)),S),!,
       write(' '),write(H),write(','),write(D),write(' ')
      ; write('.')
      ),
      printchain(S,Y)
   ;true).

printfacts(S) :-
    member(F,S), write(F), write(' '), fail.
printfacts(_).
