#program dynamic.
% slide(R,D) - slides a ring (crossed by a string) towards string direction D:{p,n}
% R must be a ring, not a loop
% R must be crossed by one segment X only
slided(D,X,f(R,E)) :- o(slide(R,D)), 'h(cross(X),f(R,E)).
slided(D,X) :- slided(D,X,_).
%:- slided(_,X), slided(_,Y), X!=Y.

%%%%% If D=p we slide forward: we swap crossings for X -> Y
c(cross(X),F) :- slided(p,X), 'h(next(X),Y), 'h(cross(Y),F).
c(cross(Y),F) :- slided(p,X,F), 'h(next(X),Y).

% X -> Y: crossings through l(A,Y)  renamed to l(A,X)
upd_end(Y,X) :- slided(p,X), 'h(next(X),Y).

% X->Y->Z: crossings through loop l(Z,A) are renamed to l(Y,A)
upd_start(Z,Y) :- slided(p,X), 'h(next(X),Y), 'h(next(Y),Z).

% If X -> Y and Y was the end of the string, we remove X's edge
remove(X):- slided(p,X), 'h(next(X),Y), 'end(S,Y).

%%%%% If D=n we slide backwards: we swap crossings for W -> X
c(cross(X),F) :- slided(n,X), 'h(next(W),X), 'h(cross(W),F).
c(cross(W),F) :- slided(n,X,F), 'h(next(W),X).

% Crossings through l(X,B) renamed to l(Y,B)
upd_start(X,Y) :- slided(n,X), 'h(next(X),Y).
% Crossings through l(A,W) renamed to l(A,X)
upd_end(W,X) :-  slided(n,X), 'h(next(W),X).

% If X was the start of the string, we remove X's edge
remove(X):- slided(n,X), 'h(start(S),X).
% ... and take Y as new string start
c(start(S),Y) :- slided(n,X), 'h(start(S),X), 'h(next(X),Y).

#show slided/2.
