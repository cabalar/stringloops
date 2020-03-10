%%%%%%%%% Picking action %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program dynamic.

% pick(X,F) - pick segment X towards face F
% We create 2 new segments M+1, M+2
% and form the chain --X-> F --M+1-> F1 --M+2->

pickseg(X) :- o(pick(X,_)).
picking :- pickseg(_).

c(max,M+2) :- picking, 'h(max,M).	  

c(next(X),M+1) :- pickseg(X), 'h(max,M).
c(cross(X),F)  :- o(pick(X,F)), 'h(max,M).

c(next(M+1),M+2) :- picking, 'h(max,M).
c(cross(M+1),F1) :- o(pick(_,F)), 'h(max,M), F1=@opp(F).

c(next(M+2),Y)  :- pickseg(X), 'h(max,M), 'h(next(X),Y).
c(cross(M+2),F) :- pickseg(X), 'h(max,M), 'h(cross(X),F).


%%%%% Loop renaming and update
% If W crossed a loop l(A,X) and X was not crossing to F, 
% we update W's crossing renaming l(A,X) to l(A,M+2)
	      
upd_end(X,M+2) :- o(pick(X,F)), 'h(cross(X),F1), F!=F1, 'h(max,M).


%%%%% Embracing
% If X was inside l(A,B) and B crossed to F, we are creating 3 new loops
% l(A,X) - l(M+1,M+1) - l(M+2,B) if B!=X
% l(A,X) - l(M+1,M+1) - l(M+2,M+2) if B=X

% A segment W crossing l(A,B) towards D
pickcross(W,A,B,D) :-
    o(pick(X,F)), 'inloop(X,A,B),'h(cross(B),F),
    'h(cross(W),f(l(A,B),D)).

% is always assigned to l(A,X), if not embraced
c(cross(W),f(l(A,X),D)) :- o(pick(X,_)), pickcross(W,A,_,D), not o(embrace(W)).

% is assigned to l(M+2,...) if embraced
c(cross(W),f(l(M+2,B),D)) :-
    o(pick(X,_)), pickcross(W,A,B,D), B!=X, o(embrace(W)), 'h(max,M).
c(cross(W),f(l(M+2,M+2),D)) :- 
    o(pick(X,_)), pickcross(W,A,X,D), o(embrace(W)), 'h(max,M).

