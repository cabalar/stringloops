#program dynamic.

%%%% Effects on string tips linked to the object
% (PL) When A linked to the end of S, and last crossing was through opposite of F
o(pullend(S))   :- o(passobj(A,F)), 'h(linked(A,tip(S,p)),true), 
                     'end(S,X), 'h(next(Z),X), 'h(cross(Z),F1), F1=@opp(F).
% (PR) Otherwise, when A linked to the end of S...
o(passend(S,F))   :- o(passobj(A,F)), 'h(linked(A,tip(S,p)),true), not o(pullend(S)).

% (NR) When A linked to the start of S, and first crossing was through F
o(pullstart(S)) :- o(passobj(A,F)), 'h(linked(A,tip(S,n)),true), 
                     'h(start(S),X), 'h(next(X),Y), 'h(cross(Y),F).
% (NL) Otherwise, when A linked to the start of S...
o(passstart(S,F)) :- o(passobj(A,F)), 'h(linked(A,tip(S,n)),true), not o(pullstart(S)).

%%%% Effects on strings crossing A
% crossing(X) = segment X was passing through A
crossing(X) :- o(passobj(A,F)), 'h(cross(X),f(A,D)).
passface(F) :- o(passobj(A,F)).

prevoppos(X) :- passface(F), crossing(X), 'h(next(Z),X), 'h(cross(Z),F1), F1=@opp(F).
nextequal(X) :- passface(F), crossing(X), 'h(next(X),Y), 'h(cross(Y),F).

slideobj(p,X) :- crossing(X), nextequal(X), not prevoppos(X).
slideobj(n,X) :- crossing(X), prevoppos(X), not nextequal(X).

c(cross(X),F)  :- slideobj(D,X), passface(F).
c(cross(Y),FA) :- slideobj(p,X), 'h(cross(X),FA), 'h(next(X),Y).
c(cross(Z),FA) :- slideobj(n,X), 'h(cross(X),FA), 'h(next(Z),X).

pickobject(X) :- crossing(X), not prevoppos(X), not nextequal(X).
c(max,3*M)     :- pickobject(X), 'h(max,M).

c(next(X),M1)     :- pickobject(X), 'h(max,M),M1=@newseg(M,X).
c(cross(X),F)     :- pickobject(X), passface(F).
c(next(M1),M1+1)  :- pickobject(X), 'h(max,M),  M1=@newseg(M,X).
c(cross(M1),FA)   :- pickobject(X), 'h(cross(X),FA), 'h(max,M), M1=@newseg(M,X).
c(next(M1+1),Y)   :- pickobject(X), 'h(next(X),Y), 'h(max,M), M1=@newseg(M,X).
c(cross(M1+1),F1) :- pickobject(X), passface(F), F1=@opp(F), 'h(max,M), M1=@newseg(M,X).

pullobject(X) :- o(passobj(A,F)), prevoppos(X), nextequal(X).
c(next(Z),W)  :-  pullobject(X), 'h(next(Z),X), 'h(next(X),Y), 'h(next(Y),W).
c(cross(Z),FA)  :-  pullobject(X), 'h(next(Z),X), 'h(cross(X),FA).
remove(X)  :-  pullobject(X).
remove(Y)  :-  pullobject(X), 'h(next(X),Y).


#script (python)
import clingo
def newseg(m,n):
     a=int(str(m))
     b=int(str(n))		
     return a+2*b-1	   
#end.
