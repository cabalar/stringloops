%% shrink - atomic action that joins consecutive segments with no crossings

#program dynamic.

%%%% sequences of consecutive segments with no crossings

consec(X,Y) :- o(shrink), 'h(next(X),Y), not 'crosses(X).
seqfirst(X) :- consec(X,Y), #count{W: consec(W,X)}=0.

% replaces(X,Y) - segment Y is replaced by X
replaces(X,Y) :- seqfirst(X), consec(X,Y).
replaces(X,Z) :- replaces(X,Y), consec(Y,Z).
sequence(X,Y) :- replaces(X,Y), #count{Z:consec(Y,Z)}=0.

replaced(Y) :-  replaces(_,Y).
renamed(l(A,B)) :- replaced(A), 'h(cross(_),f(l(A,B),_)).
renamed(l(A,B)) :- replaced(B), 'h(cross(_),f(l(A,B),_)).


map(Y,X) :- replaces(X,Y).
map(Y,Y) :- 'segment(Y), not replaced(Y).
map(l(A,B),l(A1,B1)) :- renamed(l(A,B)), map(A,A1), map(B,B1).
map(H,H) :- 'h(cross(_),f(H,_)), not renamed(H).

% X -> .... -> Y collapses to X
c(next(X),Z1)  :- sequence(X,Y), 'h(next(Y),Z), map(Z,Z1).
c(cross(X),f(L1,D)) :- sequence(X,Y), 'h(cross(Y),f(L,D)), map(L,L1).
remove(X)     :- sequence(X,Y), 'end(S,Y).
remove(Y)     :- replaces(X,Y).

c(cross(W1),f(L1,D)) :- 
     'h(cross(W),f(L,D)), renamed(L), map(L,L1), map(W,W1).
