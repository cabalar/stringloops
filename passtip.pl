%%% Passing tips %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#program dynamic.

c(max,M+1)    :- o(passend(_,_)), 'h(max,M).
c(next(X),M)  :- o(passend(S,_)), 'end(S,X), h(max,M).
c(cross(X),F) :- o(passend(S,F)), 'end(S,X).

c(max,M+1)     :- o(passstart(_,_)), 'h(max,M).
c(next(M),X)   :- o(passstart(S,_)), 'h(start(S),X), h(max,M).
c(cross(M),F1) :- o(passstart(S,F)), F1=@opp(F), h(max,M).
c(start(S),M)  :- o(passstart(S,_)), h(max,M).

% --X-> F --Y-> end
remove(X) :- o(pullend(S)), 'end(S,Y), 'h(next(X),Y).

remove(X) :- o(pullstart(S)), 'h(start(S),X), 'h(next(X),Y).
c(start(S),Y) :- o(pullstart(S)), 'h(start(S),X), 'h(next(X),Y).
