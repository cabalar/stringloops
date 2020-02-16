#program initial.

h(start(s),0).
h(start(t),1).

% Pulling crossed loop
#program initial.
&tel{ &true
      ;> o(pick(0,f(h1,p)))
	  
%       h1     
%  --0->||--2-+
%       ||    | 
%  +-3--||<---+

      ;> o(passend(t,f(l(2,2),p)))
      ;> o(pull(l(2,2))) ;> o(shrink)	  
}.
