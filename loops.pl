#program always.
%%% Detecting loops
loop(X,Y) :- h(cross(W),F), h(next(W),X),
	       h(cross(Y),F2), F2=@opp(F), connect(X,Y).
loop(X,X) :- h(cross(W),F), h(next(W),X), h(cross(X),F2), F2=@opp(F).

inloop(X,X,B) :- loop(X,B).
inloop(X,A,X) :- loop(A,X).
inloop(X,A,B) :- loop(A,B), connect(A,X), connect(X,B).
inloop(X) :- inloop(X,_,_).

#program dynamic.
%%%%%%%% Loop updates
% upd_start(X,Y) - loop l(X,B) becomes l(Y,B)
c(cross(W),f(l(Y,B),D)) :- upd_start(X,Y), 'h(cross(W),f(l(X,B),D)).

% upd_end(X,Y) - loop l(A,X) becomes l(A,Y)
c(cross(W),f(l(A,Y),D)) :- upd_end(X,Y), 'h(cross(W),f(l(A,X),D)).

% upd_loop(L1,L2) -  loop L1 becomes L2
c(cross(W),f(L2,D)) :- upd_loop(L1,L2), 'h(cross(W),f(L1,D)).

#show loop/2.
