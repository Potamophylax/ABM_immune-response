globals
[collisions contacts Mean_tr_time Sum_tr_time amount_gone_cells Mean_sch_time Sum_sch_time amount_cont_cells
 Calc_num      ; Current calculation number
 cnt_rec       ; Tick counter for output in file 
  ]

turtles-own 
[ angle state cnt_1 cnt_2 cnt_3 cnt_4 contact_flag tr_time crt_time sch_time]

patches-own
[ sinusity 
  DC_center       ; This patch is the center of the Dendritic Cell, if it has value of 1. Actual for 8 patches.
  stop-zone       ; The zone in which the centers of other DCs cannot be located, otherwise they will be located too close to each other.
]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to cycle            ; The function of carrying out a large number of calculations in a row
  let i 1
  repeat Calc_amount  
  [    
    setup
  
    set Calc_num i
    
    while [ ticks <= Time ]
     [ go ]
    
    calculate_tr_time
    calculate_sch_time
          
    file-open word "Grad 1-" (word (word Prob_chem "_") (word what-a-boundary? "_") (word Time " ticks.txt"))
    
    file-open word "Grad 1-" (word (word Prob_chem "_") (word what-a-boundary?"_")(word Time " ticks_attach.txt")) 
    
    file-type precision Mean_tr_time 2
    file-type " "
    file-type precision Mean_sch_time 2
    file-type " "
    file-print Calc_num
    
    
    file-close
  
  set i i + 1
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to setup
  
  clear-all
  
  setup-patches
  
  setup-turtles
  
  draw-walls
    
  reset-ticks
  
end
;
;
;
;
to
  setup-patches                 ; DC construction 
  ask patches [set pcolor blue]
  let i 0
  let j 0
  repeat 200 
  [
    ask patch (-44 + random 88 ) (-44 + random 88 )
    [ if( stop-zone != 1 ) 
      [ set i i + 1
        let px pxcor 
        let py pycor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ifelse show-gradient?
        [
          ask patch px py
          [ ask patches in-radius 5
             [ set pcolor 4 ]
            ask patches in-radius 20
             [ set stop-zone 1 ] 
          ]
        ]
        [
          ask patch px py
          [ ask patches in-radius 5
            [ set pcolor blue ]
            ask patches in-radius 20
             [ set stop-zone 1 ]
          ]
        ] 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ask patch px py
        [ set pcolor black 
          set DC_center 1  ]

        ask patch (px - 1) py
        [ set pcolor black ]

        ask patch (px + 1) py
        [ set pcolor black ]
   
        ask patch px (py - 1)
        [ set pcolor black ]
   
        ask patch px (py + 1)
        [ set pcolor black ]      
      
      ]]
    if (i = 8) [stop]
  ]
end
;
;
;
;
to draw-walls
  ask patches with [abs pxcor = 50] [ set pcolor violet ] ; periodic boundary conditions by violet color
  ask patches with [pycor = 50] [ set pcolor green ]  ; Non-penetrable wall of the capsule was drawn
  ask patches with [pycor = -50] [ set pcolor green ] ; Non-penetrable wall of the capsule was drawn
  
  if what-a-boundary? = "entire adsorbing border"
  [  ask patches with [abs pycor = 50] 
      [ set pcolor blue 
        set sinusity 1
      ] ; All bottom boundary is free for exit
  ]
  
  if what-a-boundary? = "120 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -40]  with [pxcor < -10] 
      [ set pcolor blue 
        set sinusity 1
      ]

     ask patches with [abs pycor = 50] with [pxcor > 10]  with [pxcor < 40] 
     [ set pcolor blue 
       set sinusity 1
     ]
  ]
   
  if what-a-boundary? = "28 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -27]  with [pxcor < -20] 
      [ set pcolor blue 
        set sinusity 1
      ]

     ask patches with [abs pycor = 50] with [pxcor > 20]  with [pxcor < 27] 
     [ set pcolor blue 
       set sinusity 1
     ]
  ]
  
  if what-a-boundary? = "20 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -30]  with [pxcor < -25] 
      [ set pcolor blue 
        set sinusity 1
      ]

     ask patches with [abs pycor = 50] with [pxcor > 25]  with [pxcor < 30] 
     [ set pcolor blue 
       set sinusity 1
     ]
  ]
  
    if what-a-boundary? = "60 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -35]  with [pxcor < -20] 
      [ set pcolor blue 
        set sinusity 1
      ] ; Medullary Sinus was drawn

     ask patches with [abs pycor = 50] with [pxcor > 20]  with [pxcor < 35] 
     [ set pcolor blue 
       set sinusity 1
     ]
  ]
  
  if what-a-boundary? = "52 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -33]  with [pxcor < -20] 
      [ set pcolor blue 
        set sinusity 1
      ] ; Medullary Sinus was drawn

     ask patches with [abs pycor = 50] with [pxcor > 20]  with [pxcor < 33] 
     [ set pcolor blue 
       set sinusity 1
     ]
  ]
  
      if what-a-boundary? = "64 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -36]  with [pxcor < -20] 
      [ set pcolor blue 
        set sinusity 1
      ] ; Medullary Sinus was drawn

     ask patches with [abs pycor = 50] with [pxcor > 20]  with [pxcor < 36] 
     [ set pcolor blue 
       set sinusity 1
     ]
  ]
  
      if what-a-boundary? = "40 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -35]  with [pxcor < -25] 
      [ set pcolor blue 
        set sinusity 1
      ] ; Medullary Sinus was drawn

     ask patches with [abs pycor = 50] with [pxcor > 25]  with [pxcor < 35] 
     [ set pcolor blue 
       set sinusity 1
     ]
  ]
  
      if what-a-boundary? = "32 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -34]  with [pxcor < -26] 
      [ set pcolor blue 
        set sinusity 1
      ] ; Medullary Sinus was drawn

     ask patches with [abs pycor = 50] with [pxcor > 26]  with [pxcor < 34] 
     [ set pcolor blue 
       set sinusity 1
     ]
  ]  
  
  if what-a-boundary? = "8 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -2]  with [pxcor < 2] 
      [ set pcolor blue 
        set sinusity 1
      ] ; Medullary Sinus was drawn 
  ]
  
    if what-a-boundary? = "no passage"
  [  ask patches with [abs pycor = 50] 
      [ set pcolor green 
        set sinusity 0
      ]                             ; All boundary is closed
  ]   
end
;
;
;
;

to setup-turtles
  set-default-shape turtles "circle"
  crt number 
  [
    set color grey
    setxy random-xcor random-ycor
    set size t_size
    set state 0
    set contact_flag 0
    set crt_time 0
  ]
  ask turtle 1 [set color red]
  
  ask turtles [
   if
   pcolor = black [die]
   ]
end
;
;
;
;
to
  go
  ; When calculations will stopped?
  if
  ticks >= 120000 [ stop ]
  
  move-turtles
  
  ;measure_tr_time
  
  gradient-move
  
  free-move-turtles
  
  contact-change
  contact-count
  
  wait-change
  ;wait-count
    
  change-state
  duration-count
  
  chemokine_overdose
  chemokine_reset 
  saturation-count
  
  wake
  
  recolor
  
  save-data
  tick
end
    
to
  move-turtles
  ;
  ask turtles with [pcolor != 4] [
  
    rt random 80
    lt random 80
   
    if not any? (turtles-on patch-ahead 1) with [self != myself] and [pcolor] of patch-ahead 1 != black and [pcolor] of patch-ahead 1 != green and state != 1
      [ fd 1 ]
    ]
  
   turtles-out
end
;
;
;
;
to
  gradient-move  ; Motion in the chemokine clouds is oriented towards DC centre in one step out of three, for example 
  ask turtles with [pcolor = 4] with [ state = 4]
  [ ifelse random Prob_chem = 0    
      [ 
        let target-patch min-one-of (patches with [DC_center = 1]) [distance myself]
        if target-patch != nobody 
          [ set heading towards target-patch ]
        if not any? (turtles-on patch-ahead 1) with [self != myself] and [pcolor] of patch-ahead 1 != black ; and state != 1 and pcolor = 4
          [fd 1]
      ]
      
      [
        rt random 80
        lt random 80
        if not any? (turtles-on patch-ahead 1) with [self != myself] and [pcolor] of patch-ahead 1 != black ;and state != 1 and pcolor = 4
         [fd 1]
      ]        
   ]
  
end
;
;
;
;
to
  free-move-turtles
  ;
  ask turtles with [pcolor = 4 and state = 3] [
  
    rt random 80
    lt random 80
   
    if not any? (turtles-on patch-ahead 1) with [self != myself] and [pcolor] of patch-ahead 1 != black ;and [pcolor] of patch-ahead 1 != green and state = 3 and pcolor = 4
      [ fd 1 ]
    ]
end
 
to measure_tr_time ; Transit time measurements
  ask turtle 1
  [
    if ( [pycor] of patch-ahead 1 = -50) 
    [ 
      set tr_time ticks
      set Mean_tr_time Mean_tr_time + tr_time
    ]
  ]  
end 
 
to turtles-out ; T-cells go to the bloodstream through bottom boundary and at the same time new T cells come into system from side boundaries to remain T cell density
  ask turtles
  [
    if ( [sinusity] of patch-ahead 1 = 1) 
       
   ; [setxy -50 random-ycor
   ; set color yellow
   ;rt random-float 360
  ;   set contact_flag 0]
   ; ]
  
    [ ask patch -50 random-ycor 
      [sprout 1 
        [
          set color yellow
          set size t_size
          rt random-float 360
          set crt_time ticks
        ]
      ]
      
      set tr_time ticks - crt_time
      set amount_gone_cells amount_gone_cells + 1
      set Sum_tr_time Sum_tr_time + tr_time
      die
    ]    
  ]  
end

to
  count-collisions ; Count T cell - DC contacts and unique contacts
  ask turtles 
  [
    
   if [pcolor] of patch-ahead 1 = black and state != 1 and contact_flag = 0 ;and state != 3
   
     [ if random Prob_contact = 0 
       [ set collisions collisions + 1
         set sch_time ticks - crt_time
         set Sum_sch_time Sum_sch_time + sch_time
         set amount_cont_cells amount_cont_cells + 1
         set contact_flag 1
       ]
     ]
   ]
end

to
  chemokine_overdose ; Start ticks counting before desensitization start
  ask turtles
  [ if pcolor = 4 and state = 0
    [
      set state 4
      set color orange + 3      
    ]
  ]  
end

; Yuri add
to
  chemokine_reset ; Reset the state of desensitization waiting and the corresponding counter to zero after the lymphocyte has left the gradient cloud with a counter filled less than half
  ask turtles
  [ if pcolor = blue and state = 4 and cnt_4 <= 10 ; It is hardly necessary to continue counting the waiting for desensitization, if the lymphocyte is no longer in a gradient.
    [ 
      set state 0
      set cnt_4 0
      ifelse contact_flag = 1
        [ set color yellow  ]  
        [ set color grey    ]  
        
    ]
  ]  
end

to
  saturation-count
  ask turtles
   [ if state = 4
     [
       set cnt_4 cnt_4 + 1
     ]
   ]      
end

to
  contact-change ; Transition to the contact state with DC
  ask turtles
  [ if [pcolor] of patch-ahead 1 = black and state != 1 
    [  
     if random Prob_contact = 0
      [ if contact_flag = 0
         [
            set collisions collisions + 1
            set sch_time ticks - crt_time
            set Sum_sch_time Sum_sch_time + sch_time
            set amount_cont_cells amount_cont_cells + 1
            set contact_flag 1

          ]
        set state 1
       
  
        set contacts contacts + 1 
      ]
    ]  
  ]  
end

to
  contact-count
  ask turtles
   [ if state = 1
     [
       set cnt_1 cnt_1 + 1
     ]
   ]      
end

to
  wait-change ; Counting time for transition to the desensitization state
  
  ask turtles
  [
     if cnt_1 = 6
       [
        set state 3
        set color orange
        set cnt_1 0
 
       ]  
    ]
end


to
  change-state ; transition to the desensitization state
  
  ask turtles
    [
     if cnt_4 = 20
       [
        set state 3
        set color orange
        ;set cnt_2 0
        set cnt_4 0
       ]  
    ]
end

to
  duration-count  ; Duration of desensitization
  ask turtles
   [ if state = 3 and pcolor = blue
     [
       set cnt_3 cnt_3 + 1
     ]
   ]      
end

to
  wake  ; Go back to the resensitized state
  ask turtles
    [
     if cnt_3 = 20
       [
        set state 0
        set cnt_3 0
 
       ]  
    ]
end


to     
  recolor ; 
  ask turtles with [color = orange]
     [ if state = 0
       [ set color yellow ]     
     ]
end

to
  calculate_tr_time
  ifelse amount_gone_cells != 0
  [set Mean_tr_time Sum_tr_time / amount_gone_cells]
  [set Mean_tr_time "N/A"]
end

to
  calculate_sch_time
  
  ifelse amount_cont_cells != 0
  [set Mean_sch_time Sum_sch_time / amount_cont_cells]
  [set Mean_sch_time "N/A"]
end

to                                      ;; Write results in one file
  save-data
    file-open word "Grad 1-" (word (word Prob_chem "_") (word what-a-boundary? "_") (word Time " ticks.txt"))
 

    if ( cnt_rec = output-period )
      [file-type ticks / 2
       file-type " "
       file-type contacts
       file-type " "
       file-type collisions
       file-type " "
       file-print Calc_num
       set cnt_rec 0 
      ] 
    set cnt_rec cnt_rec + 1  
    file-close
end
@#$#@#$#@
GRAPHICS-WINDOW
331
10
1149
849
50
50
8.0
1
10
1
1
1
0
1
1
1
-50
50
-50
50
1
1
1
ticks
30.0

BUTTON
23
288
86
321
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
23
341
86
374
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
1166
411
1636
849
plot 1
Time
Number of unique contacts
0.0
20.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot collisions"

INPUTBOX
165
288
273
348
number
2000
1
0
Number

BUTTON
1180
236
1351
282
Mean transit time
calculate_tr_time
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
1203
299
1336
344
Mean transit time:
Mean_tr_time
2
1
11

MONITOR
1346
153
1465
198
NIL
amount_gone_cells
17
1
11

BUTTON
1469
235
1641
281
Mean search time
calculate_sch_time
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
1490
299
1622
344
Mean search time:
Mean_sch_time
2
1
11

MONITOR
1705
470
1861
515
Unique contacts number:
amount_cont_cells
17
1
11

SWITCH
168
583
309
616
show-gradient?
show-gradient?
1
1
-1000

CHOOSER
131
646
310
691
what-a-boundary?
what-a-boundary?
"entire adsorbing border" "120 patches" "64 patches" "60 patches" "52 patches" "40 patches" "32 patches" "28 patches" "20 patches" "8 patches" "no passage"
1

INPUTBOX
165
218
276
278
t_size
1
1
0
Number

TEXTBOX
170
198
295
224
Displayed T-cell size:
11
0.0
1

MONITOR
1703
411
1866
456
Total number of contacts:
contacts
17
1
11

INPUTBOX
12
435
131
495
Prob_chem
3
1
0
Number

INPUTBOX
13
524
133
584
Prob_contact
1
1
0
Number

TEXTBOX
20
511
170
529
Contact probability:
11
0.0
1

TEXTBOX
17
417
167
445
Chemotaxis probability:
11
0.0
1

BUTTON
80
16
231
49
Several calculations
cycle
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

INPUTBOX
7
76
88
136
Calc_amount
2
1
0
Number

INPUTBOX
115
76
196
136
Time
1000
1
0
Number

INPUTBOX
227
76
310
136
Output-period
1000
1
0
Number

MONITOR
1187
12
1298
81
№ расчёта
Calc_num
17
1
17

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.1.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
