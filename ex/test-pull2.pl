#program initial.

h(start(s),0).
h(start(t),1).

% This example shows how pulling may rename the loop in a crossing through parent loop
#program initial.
&tel{ &true
	  ;> o(pick(0,f(h1,p)))
	  ;> o(pick(2,f(h2,p)))
	  ;> o(pick(4,f(h3,p)))

%       h1     h2     h3
%  --0->||--2->||--4->||--6-+
%       ||     ||     ||    |
%  <-3--||<--5-||<-7--||<---+
%       ||     ||     ||

	  ;> o(passend(t,f(l(4,7),p)))
	  ;> o(pull(l(6,6))) ;> o(shrink)
}.
