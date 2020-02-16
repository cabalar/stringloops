% "African Ring" puzzle
#program initial.

h(start(s),0).
h(next(0),1). h(cross(0),f(h,n)).
h(next(1),2). h(cross(1),f(r,p)).
h(next(2),3). h(cross(2),f(l(4,4),p)).
h(next(3),4). h(cross(3),f(h,n)).
h(next(4),5). h(cross(4),f(h,p)).
h(next(5),6). h(cross(5),f(l(4,4),n)).
h(next(6),7). h(cross(6),f(h,p)).

#program initial.
&tel{ &true
      ;> o(slide(r,p))
      ;> o(pick(4,f(h,p))) & o(embrace(5))
      ;> o(pull(l(9,9))) ;> o(shrink)
      ;> o(pull(l(4,4))) ;> o(shrink)
      ;> o(slide(r,p))
      ;> o(slide(r,p))
      ;> o(pull(l(12,12))) ;> o(shrink)
      ;> o(pull(l(10,10))) ;> o(shrink)
      ;> o(pull(l(3,3))) ;> o(shrink)
      ;> o(slide(r,p))
    }.
