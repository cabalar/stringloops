#program initial.

h(start(s),0).
h(start(t),1).

&tel{ &true
      ;> o(pick(0,f(h1,p)))
      ;> o(pick(2,f(h2,p)))
	  
%       h1     h2
%       ||     ||
%  --0->||--2->||--4-+
%       ||     ||    |
%  <-3--||<-5--||<---+
%       ||     ||
       ;> o(passend(t,f(l(2,5),p)))
       ;> o(pull(l(4,4)))
       ;> o(shrink)
    }.

