#program initial.

h(start(s),0).

&tel{ &true
      ;> o(passend(s,f(h1,p)))
      ;> o(passend(s,f(h2,n)))
      ;> o(passend(s,f(h3,p)))
      ;> o(passend(s,f(h2,p)))
	  
%       h1     
%  --0->||-------2-----+
%       ||             |  
%       ||  +-3--||<---+
%       ||  |    ||    
%       ||  +--->||--4-+
%       ||       ||    |
%       ||  <-5--||<---+

      ;> o(passend(t,f(l(4,4),n)))
      ;> o(pull(l(4,4)))
      ;> o(shrink)
    }.

