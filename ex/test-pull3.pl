#program initial.

h(start(s),0).
h(start(t),1).

% Three adjacent loops
#program initial.
&tel{ &true
	  ;> o(pick(0,f(h1,n)))
	  ;> o(pick(2,f(h1,p)))

%       h1     
%  --0->||--2-+
%       ||    | 
%  +-4--||<---+
%  |    ||     
%  +--->||--5-+
%       ||    | 
%  +-3--||<---+
	      
	  ;> o(passend(t,f(l(2,2),p)))
	  ;> o(passend(t,f(l(5,5),n)))
	  ;> o(pull(l(4,4))) ;> o(shrink)
}.
