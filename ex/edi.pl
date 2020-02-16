% "Easy does it" puzzle
#program initial.

h(start(s1),0).
h(next(0),1). h(cross(0),f(r3,p)).
h(next(1),2). h(cross(1),f(r3,n)).

h(start(ps),3).
h(next(3),4). h(cross(3),f(r2,p)).
h(next(4),5). h(cross(4),f(r1,p)).

h(start(s2),6).
h(next(6),7). h(cross(6),f(l(1,1),p)).

#program initial.
&tel{ &true
      ;> o(pick(1,f(r1,p)))
      ;> o(passend(ps,f(l(8,8),p)))   
      ;> o(pull(l(8,8))) ;> o(shrink)  
      ;> o(pull(l(5,5))) ;> o(shrink)
      ;> o(slide(r1,n))
      ;> o(pullend(s2))
      ;> o(pullend(ps))
      ;> o(pull(l(1,1))) ;> o(shrink)
    }.
