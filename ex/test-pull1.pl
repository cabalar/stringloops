#program initial.

h(start(s),0).

#program initial.
&tel{ &true
      ;> o(pick(0,f(h1,p)))
      ;> o(pick(1,f(h2,p)))

%       h1     h2
%  --0->||--1->||--3-+
%       ||     ||    |  
%  <-2--||<--4-||<---+
%       ||     ||
%
      ;> o(pull(l(3,3))) ;> o(shrink)
      ;> o(pull(l(1,1))) ;> o(shrink)
}.
