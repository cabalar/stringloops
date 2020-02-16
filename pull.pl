%%%%%%%%% Pulling action (segments with 1 crossing string, at most) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program dynamic.

% pull(L) - pull, undoing loop L
% L must be an existing loop
:- o(pull(l(X,Y))), not 'loop(X,Y).

% If crossed, we assume only one crossing segment
crossedby(Z,D) :- 'h(cross(Z),f(L,D)), o(pull(L)).
crossed :- crossedby(_,_).

:- crossedby(Z,_), crossedby(W,_), Z!=W.

pull(X1,X2) :- o(pull(l(X1,X2))).

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uncrossed pull segment
%  --W-> F --X1->...--X2-> F1 --Y->
% We just remove the crossings F and F1 leaving:
%  --W->.--X1->...--X2->.--Y->

c(cross(W)) :- o(pull(l(X1,_))), not crossed, 'h(next(W),X1).
c(cross(X2)) :- o(pull(l(_,X2))), not crossed.

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Crossed pull segment

% The picked string will form new loop l(M+1,M+2)

c(max,M+2) :- crossed, 'h(max,M).
c(next(M+1),M+2) :- crossed, 'h(max,M).

% In the pulled string
%  --W-> F --X1-> ... --X2-> F1 --Y->
% we only change the crossings in the following way:
%  --W-> l(M+1,M+2) --X1-> ... --X2-> . --Y->
c(cross(W), f(l(M+1,M+2),D)) :- 
     o(pull(l(X1,_))), 'h(next(W),X1), crossedby(Z,D),'h(max,M).
c(cross(X2)) :- o(pull(l(_,X2))), crossed.

% In the picked string we go from this
%   --Z-> l(X1,X2) --U-> 
% to this
%   --Z-> F --M+1-> . --M+2-> F1 --U->
c(next(Z),M+1) :- crossedby(Z,_), 'h(max,M).
c(cross(Z),F) :- crossedby(Z,_), o(pull(l(_,X2))), 'h(cross(X2),F), 'h(max,M).
c(next(M+2),U) :- crossedby(Z,_), 'h(next(Z),U), 'h(max,M).
c(cross(M+2),F1) :- crossed, o(pull(l(_,X2))), 'h(cross(X2),F), F1=@opp(F), 'h(max,M).

% If X has a parent loop P on a different hole, we add crossing:
%  --M+1-> P --M+2->
c(cross(M+1),f(l(A,B),D)) :- 
     o(pull(l(X1,X2))), crossed, 'parentloop(l(X1,X2),l(A,B)),
    'h(cross(X2),f(H,_)), 'h(cross(B),f(H2,_)), H!=H2, % different hole
    crossedby(_,D), 'h(max,M).


%%%%%%%%%%%%%%%%%%%%%%%%%%
% Left adjacent loop
% l(A,W) ... W -> X1 ... X2
% l(A,W) was a left adjacent loop with parent loop P

upd_loop(l(A,W),P) :-
    o(pull(l(X1,_))), 'h(next(W),X1), 'leafloop(l(A,W)), 'parentloop(l(A,W),P).

% l(A,W) was a left adjacent loop with no parent
c(cross(Z)) :- o(pull(l(X1,_))), 'h(next(W),X1), 
    'leafloop(l(A,W)), not 'hasparent(l(A,W)), 'h(cross(Z),f(l(A,W),_)).

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Right adjacent loop
%  X1 ... X2 -> Y ... l(Y,B)
% l(Y,B) was a right adjacent loop with parent loop P

upd_loop(l(Y,V),P) :-
    o(pull(l(_,X2))), 'h(next(X2),Y), 'leafloop(l(Y,V)), 'parentloop(l(Y,V),P).

% l(Y,B) was a right adjacent loop with no parent
c(cross(Z)) :- o(pull(l(_,X2))), 'h(next(X2),Y), 
    'leafloop(l(Y,V)), not 'hasparent(l(Y,V)), 'h(cross(Z),f(l(Y,V),_)).

%%%%%%%%%%%%%%%%%%%%%%%%%%
#program always.
subloop(l(A,B),l(X,Y)) :- loop(A,B), loop(X,Y), connect(X,A), connect(B,Y).
subloop(l(A,B),l(A,Y)) :- loop(A,B), loop(A,Y), connect(B,Y).
subloop(l(A,B),l(X,B)) :- loop(A,B), loop(X,B), connect(X,A).
indirectsubloop(L,N) :- subloop(L,M), subloop(M,N).
parentloop(L,M) :- subloop(L,M), not indirectsubloop(L,M).
haschild(L) :- parentloop(_,L).
hasparent(L) :- parentloop(L,_).
leafloop(l(A,B)) :- loop(A,B), not haschild(l(A,B)). 

