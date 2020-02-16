:- dynamic answer/2,numanswers/1,curanswer/1.

assert_answer(N) :-
    answer(N,S),
    assert_all(S).

assert_all([]):-!.
assert_all([F|Fs]):-assertz(F),assert_all(Fs),!.

telingo(Files) :- telingo(Files,1).
telingo(Files,N) :-
    (retractall(answer(_,_)),!;true),
    (retractall(curanswer(_)),!;true),
    filenames(Files,Fnames),
    concat_atom(['telingo --verbose=0 ',N,' ',Fnames,' > answers.tmp 2> /dev/null'],Command),
%    write(Command),nl,
    shell(Command,_),set_count(numanswers,0),
    see('answers.tmp'), read_tokens, seen,
    (curanswer(_),!,new_answer,incr(numanswers,-1);true),
    delete_file('answers.tmp').

read_tokens :-
    gettoken([0' ,10],T,_),!,
    (  T='UNSATISFIABLE',!
     ; T='',!,read_tokens
     ; T='SATISFIABLE',!,read_tokens
     ; T='State',!,gettoken([0':],I,_),atom_to_term(I,J,_),gettoken([10],_,_),
       (J=0,!,new_answer; new_state ),
       read_tokens
     ; atom_to_term(T,Term,_),
       new_fact(Term),
       read_tokens
    ).
read_tokens.

new_answer :-
    numanswers(N),incr(numanswers,1),
    (N=0,!
    ; N1 is N-1, retract(curanswer(S)),reverse(S,S1),assertz(answer(N1,S1))
    ),asserta(curanswer([[]])).

new_state :-
    retract(curanswer(Ss)),
    assert(curanswer([[]|Ss])).

new_fact(F) :-
    retract(curanswer([S|Ss])),
    assert(curanswer([[F|S]|Ss])).

gettoken(Delims,Tok,Delim):-
	gettokenchars(Delims,Chars,Delim),
	atom_codes(Tok,Chars).

gettokenchars(Delims,Cs,Delim):-
  get0(C),!,
  ( C = -1,!,fail
  ; member(C,Delims),!,Delim=C,Cs=[]  
  ; gettokenchars(Delims,Cs0,Delim), Cs=[C|Cs0]
  ).

% Updates a dynamic predicate Pred/1 whose argument is an integer I, by adding
% a quantity X to I.
incr(Pred,X):-
	T =.. [Pred,N],
	(call(T),!, retractall(T); N=0),
	M is N + X,
	T2 =.. [Pred,M],
	asserta(T2).

set_count(Pred,X):-
	T=..[Pred,_],
	(retractall(T),!; true),
	T2=..[Pred,X],asserta(T2).

filenames([],'') :- !.
filenames([F|Fs],Txt) :- !,filenames(Fs,T),concat_atom([F,' ',T],Txt).
filenames(F,F).
