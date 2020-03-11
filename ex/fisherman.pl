% "Fisherman's Folly" puzzle
#program initial.

h(start(s),0).
h(next(0),1). h(cross(0),f(s1,p)).
h(next(1),2). h(cross(1),f(ph,p)).
h(next(2),3). h(cross(2),f(s2,p)).

h(start(post),4).
h(next(4),5). h(cross(4),f(ring,p)).

h(linked(d1,tip(s,n)),true).
h(linked(d2,tip(s,p)),true).
h(linked(ph,tip(post,p)),true).
h(linked(base,tip(post,n)),true).

#program initial.
&tel{ &true
      ;> o(passobj(d2,f(ph,n)))
      ;> o(passobj(ph,f(ring,n))) 
      ;> o(passobj(s2,f(ring,n)))
      ;> o(passobj(ring,f(ph,p)))
      ;> o(passobj(s2,f(ring,p)))
    }.

