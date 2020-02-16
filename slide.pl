#program dynamic.
% slide(R,D) - slides a ring (crossed by a string) towards string direction D:{p,n}
% R must be a ring, not a loop
% R must be crossed by one segment X only
slided(X,f(R,D)) :- o(slide(R,_)), 'h(cross(X),f(R,D)).
%:- slided(X,_), slided(Y,_), X!=Y.
nslide :- o(slide(_,n)).
pslide :- o(slide(_,p)).

%%%%% If D=p we slide forward: we swap crossings for X -> Y
c(cross(X),F) :- pslide, slided(X,_), 'h(next(X),Y), 'h(cross(Y),F).
c(cross(Y),F) :- pslide, slided(X,F), 'h(next(X),Y).

% X -> Y: crossings through l(A,Y)  renamed to l(A,X)
upd_end(Y,X) :- pslide, slided(X,_), 'h(next(X),Y).

% X->Y->Z: crossings through loop l(A,Y) are renamed to l(A,X)
upd_start(Z,Y) :- pslide, slided(X,_), 'h(next(X),Y), 'h(next(Y),Z).

% If X -> Y and Y was the end of the string, we remove X's edge
remove(X):- pslide, slided(X,_), 'h(next(X),Y), 'end(S,Y).

%%%%% If D=n we slide backwards: we swap crossings for W -> X
c(cross(X),F) :- nslide, slided(X,_), 'h(next(W),X), 'h(cross(W),F).
c(cross(W),F) :- nslide, slided(X,F), 'h(next(W),X).

% Crossings through l(X,B) renamed to l(Y,B)
upd_start(X,Y) :- nslide, slided(X,_), 'h(next(X),Y).
% Crossings through l(A,W) renamed to l(A,X)
upd_end(W,X) :-  nslide, slided(X,_), 'h(next(W),X).

% If X was the start of the string, we remove X's edge
remove(X):- nslide, slided(X,_), 'h(start(S),X).
% ... and take Y as new string start
c(start(S),Y) :- nslide, slided(X,_), 'h(start(S),X), 'h(next(X),Y).

#show slided/2.
