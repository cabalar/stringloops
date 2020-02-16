#program initial.

h(start(s),0).
h(start(t),1).

&tel{ &true
      ;> o(passend(s,f(h2,n)))
      ;> o(passend(s,f(h1,p)))
      ;> o(passend(s,f(h2,p)))
	  
%       h1     h2
%       ||     ||
%  +--->||--3->||--4->
%  |    ||     ||
%  +-------2---||<-0--
%              ||
	  
      ;> o(passend(t,f(l(2,3),n)))
      ;> o(slide(h1,p))   % try also o(slide(h1,n))
    }.
