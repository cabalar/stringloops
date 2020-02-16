
% opp(f(X,n)):=f(X,p).  opp(f(X,p)):=f(X,n).
#script (python)
import clingo

def opp(a):
	if a.name=='f' and len(a.arguments)==2:
	   b=a.arguments
	   if b[1].name=='n':
	      b[1]=clingo.Function("p")
	   elif b[1].name=='p':
	      b[1]=clingo.Function("n")
	   return clingo.Function("f",b)
	else:
 	   return a
#end.

#program always.
segment(X) :- h(start(_),X).
segment(X) :- h(next(_),X).

%%% Transitive closure for next
connect(X,Y) :- h(next(X),Y).
connect(X,Y) :- h(next(X),Z), connect(Z,Y).

%%% end(S,X): means that X is the end of string S
hasnext(X) :- h(next(X),_).
end(S,X) :- h(start(S),X), not hasnext(X).
end(S,Y) :- h(start(S),X), connect(X,Y), not hasnext(Y).
end(S,X) :- h(start(S),X), connect(X,X).  % cyclic string
    
crosses(X) :- h(cross(X),_).

#program initial.
h(max,X) :- #max{Y:segment(Y)}=X.
direction(p;n).

#program dynamic.
% Intertia for functional fluents
h(F,V) :- 'h(F,V), not c(F).
c(F) :- c(F,V).
h(F,V) :- c(F,V).

#program dynamic.

% remove(X) - removes any next(X) and cross(X)
c(next(X))  :- remove(X).
c(cross(X)) :- remove(X).

#show h/2.
#show o/1.
