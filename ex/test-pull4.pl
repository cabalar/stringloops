#program initial.

h(start(s),0).
h(start(t),1).

% Left adjacent loop
#program initial.
&tel{ &true
	  ;> o(passend(s,f(h1,n)))
	  ;> o(passend(s,f(h2,n)))
	  ;> o(passend(s,f(h2,p)))
	  ;> o(passend(s,f(h2,n)))
	  ;> o(passend(t,f(l(3,3),p)))
	  ;> o(pull(l(4,4))) ;> o(shrink) % t is released
}.
