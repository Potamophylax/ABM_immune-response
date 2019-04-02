globals
[collisions Mean_tr_time Sum_tr_time amount_gone_cells Mean_sch_time Sum_sch_time amount_cont_cells am_gone_red_cells dying_cells
  x_free y_free    ; coordinates of neighbour non-occupied patch
 ;thresh_level     ; activation level's treshold value, after which division can occur
  ]

turtles-own 
[ angle contacts state cnt_1 cnt_2 cnt_3 cnt_4 cnt_5 cnd 
  contact_flag    ; Was or not contact with Dendritic cell for this T cell [0, 1] 
  tr_time         ; Transit time through computational domain
  crt_time        ; Time of lymphocyte occurence in the system
  sch_time        ; T cell - DC search time
  affinity        ; Cognate or non-cognate lymphocyte 
  activity        ; Activate or non-activate T cell
  effectiveness   ; Can T cell divide or already effector [0, 1]
  doubling_time   ; Division time
  nn              ; Number of turtles-neighbours
  nbp             ; Number of neighbour non-occupied patches
  nh              ; Number of turtles on the same patch
  num_gen         ; Generation number for dividing T cells
  
  activation_time ; T cell priming time
  contact_time    ; Duration of short contacts for cognate T cells
  a_level         ; T cell activation level
  zero_level      ; Initial T cell activation level to the moment of DC contact start
  ]

patches-own
[ sinusity 
  DC_center       ; = 1 for DC center
  stop-zone       ; The zone in which the centers of other DCs cannot be located, so that they are not located too close to each other.
  
  ]

to make-movie

  ;; prompt user for movie location
  user-message "First, save your new movie file (choose a name ending with .mov)"
  let path user-new-file
  if not is-string? path [ stop ]  ;; stop if user canceled

  ;; run the model
  ;setup
  movie-start path
  movie-grab-view
  while [   ticks <= 10200 ]
    [ go
      movie-grab-view ]

  ;; export the movie
  movie-close
  user-message (word "Exported movie to " path)
end

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
  ask patches [set pcolor 47.9]
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
            [ set pcolor 47.9 ]
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
;
;
;
to draw-walls
  ask patches with [abs pxcor = 50] [ set pcolor violet ] ; designation of side boundaries with periodic conditions
  ask patches with [pycor = 50] [ set pcolor green ]  ; reflective wall of the capsule was drawn 
  ask patches with [pycor = -50] [ set pcolor green ] ; reflective wall of the capsule was drawn 
  
  if what-a-boundary? = "entire adsorbing border"
  [  ask patches with [abs pycor = 50] 
      [ set pcolor 47.9 
        set sinusity 1
      ] ; all bottom boundary is free for T cell's exit 
  ]
  
  if what-a-boundary? = "120 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -40]  with [pxcor < -10] 
      [ set pcolor 47.9 
        set sinusity 1
      ]

     ask patches with [abs pycor = 50] with [pxcor > 10]  with [pxcor < 40] 
     [ set pcolor 47.9 
       set sinusity 1
     ]
  ]
   
  if what-a-boundary? = "28 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -27]  with [pxcor < -20] 
      [ set pcolor 47.9 
        set sinusity 1
      ]

     ask patches with [abs pycor = 50] with [pxcor > 20]  with [pxcor < 27] 
     [ set pcolor 47.9 
       set sinusity 1
     ]
  ]
  
  if what-a-boundary? = "20 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -30]  with [pxcor < -25] 
      [ set pcolor 47.9 
        set sinusity 1
      ]

     ask patches with [abs pycor = 50] with [pxcor > 25]  with [pxcor < 30] 
     [ set pcolor 47.9 
       set sinusity 1
     ]
  ]
  
    if what-a-boundary? = "60 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -35]  with [pxcor < -20] 
      [ set pcolor 47.9 
        set sinusity 1
      ] ; Medullary sinus was drawn

     ask patches with [abs pycor = 50] with [pxcor > 20]  with [pxcor < 35] 
     [ set pcolor 47.9 
       set sinusity 1
     ]
  ]
  
  if what-a-boundary? = "52 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -33]  with [pxcor < -20] 
      [ set pcolor 47.9 
        set sinusity 1
      ] ; Medullary sinus was drawn

     ask patches with [abs pycor = 50] with [pxcor > 20]  with [pxcor < 33] 
     [ set pcolor 47.9 
       set sinusity 1
     ]
  ]
  
      if what-a-boundary? = "64 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -36]  with [pxcor < -20] 
      [ set pcolor 47.9 
        set sinusity 1
      ] ; Medullary sinus was drawn

     ask patches with [abs pycor = 50] with [pxcor > 20]  with [pxcor < 36] 
     [ set pcolor 47.9 
       set sinusity 1
     ]
  ]
  
      if what-a-boundary? = "40 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -35]  with [pxcor < -25] 
      [ set pcolor 47.9 
        set sinusity 1
      ] ; Medullary sinus was drawn

     ask patches with [abs pycor = 50] with [pxcor > 25]  with [pxcor < 35] 
     [ set pcolor 47.9 
       set sinusity 1
     ]
  ]
  
      if what-a-boundary? = "32 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -34]  with [pxcor < -26] 
      [ set pcolor 47.9 
        set sinusity 1
      ] ; Medullary sinus was drawn
      
     ask patches with [abs pycor = 50] with [pxcor > 26]  with [pxcor < 34] 
     [ set pcolor 47.9 
       set sinusity 1
     ]
  ]  
  
  if what-a-boundary? = "8 patches"
  [  ask patches with [abs pycor = 50] with [pxcor > -2]  with [pxcor < 2] 
      [ set pcolor 47.9 
        set sinusity 1
      ] ; Medullary sinus was drawn 
  ]
  
    if what-a-boundary? = "no passage"
  [  ask patches with [abs pycor = 50] 
      [ set pcolor green 
        set sinusity 0
      ]                             ; If there is no exit for T cells
  ]   
end
;
;
;
;

to setup-turtles
  set-default-shape turtles "circle"
  crt number + 7
  [
    set color 2
    set affinity 0
    set activity 0
    set effectiveness 0
    setxy random-xcor random-ycor
    set size 1
    set state 0
    set contact_flag 0
    set crt_time 0

  ]
   crt ncc  
  [set color red
   set affinity 1
   set activity 0      ; 
   set effectiveness 0 ; 

   setxy random-xcor random-ycor
   set size 1
   set doubling_time round random-normal 960 150
   set num_gen 0
   set activation_time round random-normal 2880 250 
  ]
  
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
  ; Stop after 120000 ticks
  if
  ticks >= sim_time [ stop ]
  
  move-cognate-nonactivate
  move-turtles
  move-noncognate
  move-effector
  
  gradient-move
  
  free-move-turtles
  
  tick
  
  count-collisions
  
  chemokine_overdose
  chemokine_reset
  saturation-count  
  
  contact-change
  contact-count
  
  wait-change
;  wait-count
    
  change-state
  duration-count
  
  wake
  
  wait-replication
  divide
  
  life-count
  kill-effectors
  
  recolor
  
  calculate_cognate_cells
  
  calculate-level
end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Part about T cell movement
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
to
  move-turtles
  ;
  ask turtles with [pcolor != 4] with [ affinity = 1 and activity = 1]
  [
  
    rt random 80
    lt random 80
   
    if not any? (turtles-on patch-ahead 1) with [self != myself] and [pcolor] of patch-ahead 1 != black and [pcolor] of patch-ahead 1 != green and state != 1
      [ fd 1 ]
  ]
   turtles-out
   return-cognate
end

to
  move-cognate-nonactivate
  ;
  ask turtles with [ affinity = 1 and activity = 0] 
  [
  
    rt random 80
    lt random 80
   
    if not any? (turtles-on patch-ahead 1) with [self != myself] and [pcolor] of patch-ahead 1 != black and [pcolor] of patch-ahead 1 != green and state != 1
      [ fd 1 ]
  ]
  
   turtles-out
   return-cognate
end

to
  move-noncognate
  ;
  ask turtles with [ affinity = 0] 
  [
  
    rt random 80
    lt random 80
   
    if not any? (turtles-on patch-ahead 1) with [self != myself] and [pcolor] of patch-ahead 1 != black and [pcolor] of patch-ahead 1 != green and state != 1 ;and pcolor != 4
      [ fd 1 ]
  ]
  
   turtles-out
end

to
  move-effector
  ;
  ask turtles with [ effectiveness = 1] 
  [
  
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
  gradient-move  ; non-random movement in the chemokine clouds
  
  ask turtles with [pcolor = 4 and affinity = 1 and activity = 1 ] with [ (state = 4 or state = 5 )] with [effectiveness = 0]
  [ ifelse random Prob_chem = 0    
      
      [ let target-patch min-one-of (patches with [DC_center = 1]) [distance myself]
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
  ;
end


;
;
;
;
to
  free-move-turtles
  ;
  ask turtles with [pcolor = 4] [
  
    rt random 80
    lt random 80
   
    if not any? (turtles-on patch-ahead 1) with [self != myself] and [pcolor] of patch-ahead 1 != black and [pcolor] of patch-ahead 1 != green and (state = 3) ;and pcolor = 4
      [ fd 1 ]
    ]
end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;  Part about T cell exit through MS and new cells occurence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
to 
  turtles-out                                    ; T-cells go to the bloodstream through the lower boundary, and immediately there are new T-cells from the side boundaries
  ask turtles with [affinity = 0]
  [
    if ( [sinusity] of patch-ahead 1 = 1) 
  
    [ ask patch -50 random-ycor 
      [
        sprout 1
         [ set color 2
           set affinity 0
           set activity 0
           set effectiveness 0
           set size 1
           rt random-float 360
           set crt_time ticks
         ]
        
        
        if random influx_rate = 0        ; With a low probability, additional cognate clones enter the system.
        [sprout 1 
          [ set color red
            set affinity 1
            set activity 0
            set num_gen 0
            set activity 0
            set effectiveness 0
            set size 1
            rt random-float 360
            set crt_time ticks
            set doubling_time round random-normal 960 150
            set activation_time round random-normal 2880 250 
          ]
         ]
          
        ]  
      
      set tr_time ticks - crt_time
      set amount_gone_cells amount_gone_cells + 1

      set Sum_tr_time Sum_tr_time + tr_time
      
      if what-a-output? = "Transit time"
      [output-print tr_time]
      
      if what-a-output? = "Cognate clones output"
        [ output-type ticks / 2
          output-type " "
          output-print am_gone_red_cells
        ]      
      die
    ]    
  ]  
end

to 
  return-cognate 
  ask turtles with [ affinity = 1]
  [
    if ( [sinusity] of patch-ahead 1 = 1) and count turtles with [ affinity = 1 ] > 1
    [       
      set tr_time ticks - crt_time
      set amount_gone_cells amount_gone_cells + 1
      set am_gone_red_cells am_gone_red_cells + 1

      set Sum_tr_time Sum_tr_time + tr_time
      
      if what-a-output? = "Transit time"
      [output-print tr_time]      
      die
    ]    
  ]  
end
;;;;;;;;;;;;;;;;;;;;;;;

to
  count-collisions ; Count contacts and unique contacts of T cells with DCs
  ask turtles with [ affinity = 0]
  [
    
   if [pcolor] of patch-ahead 1 = black and contact_flag = 0
   
     [ set collisions collisions + 1
       set contacts contacts + 1
       set sch_time ticks - crt_time
       set Sum_sch_time Sum_sch_time + sch_time
       set amount_cont_cells amount_cont_cells + 1
       if what-a-output? = "Unique contacts"
       [ output-type ticks / 2
         output-type " "
         output-print collisions
       ]
     ]
   ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Part for T cell's state changes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to
  chemokine_overdose ; The start of the countdown to the loss of the chemokine sensitivity due to too long stay in the chemokine cloud
  ask turtles with [affinity = 1] with [effectiveness != 1]
  [ if pcolor = 4 and state = 0
    [
      set state 4
      ;set color orange + 3      
    ]
  ]  
end

to
  chemokine_reset ; Reset the state of desensitizations waiting and the corresponding counter to zero after the lymphocyte has left the gradient cloud with a counter filled less than half
  ask turtles with [affinity = 1] with [effectiveness != 1]
  [ if pcolor = 47.9 and state = 4 and cnt_4 <= 10 ; It is hardly necessary to continue counting the waiting for desensitization, if the lymphocyte is no longer in a gradient.
    [ 
      set state 0
      set cnt_4 0        
    ]
  ]  
end

to
  saturation-count
  ask turtles with [affinity = 1] with [effectiveness != 1]
   [ if state = 4
     [
       set cnt_4 cnt_4 + 1
     ]
   ]      
end

to
  contact-change ; Come into DC contact state
  ask turtles with [affinity = 0]
  [ if [pcolor] of patch-ahead 1 = black and state != 1
    [
      set state 1
      set contact_flag 1      
    ]
  ]
  
  ask turtles with [effectiveness = 1]
  [ if [pcolor] of patch-ahead 1 = black and state != 1
    [
      set state 1
      set contact_flag 1
    ]
  ]
  
  ask turtles with [affinity = 1] with [effectiveness != 1]
  [ if [pcolor] of patch-ahead 1 = black and state != 1 and state != 5
    [ if random 4 != 3                                 ; 75% -- Contact probability for cognate T cells
      [set state 1
       set contact_flag 1
       set zero_level a_level
       
       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      ; 20 min and dispersion for log-normal distribution construction
       let Mu 40 
       let sigma 20 
       let beta ln(1 + sigma * sigma / (Mu * Mu)) 
       let M ln Mu - beta / 2 
       let S sqrt beta 
       set contact_time round exp(random-normal M S)
       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
  wait-change ; What happens after the contact with the DC was finished? Transition to baseline state, waiting for division or desensitization.
  
  ask turtles with [affinity = 0] ; For cells non-cognate for this antigen
  [
    if cnt_1 = 6
      [
        set state 0
        set cnt_1 0
      ]  
  ]
  
  ask turtles with [effectiveness = 1] ; For effectors
  [
    if cnt_1 = 6
      [
        set state 0
        set cnt_1 0
      ]  
  ]
  
  ask turtles with [affinity = 1] with [activity = 0] with [effectiveness != 1] ; Для родственных неактивированных T-клеток
  [
    if cnt_1 = activation_time               ; Duration of priming and first division is 24 hours.
      [ ifelse random 20 = 19                ; Transition to the activated state can occur with 95% probability
         [
           set state 3
           set cnt_1 0
           set activity 0
         ]
         [
           set state 5
           set cnt_1 0
           set activity 1
         ]
      ]  
  ]
  
  ask turtles with [affinity = 1]  with [activity = 1] with [effectiveness != 1] ; For cognate and already activated T cells.
  [
    if ( cnt_1 = contact_time )                                   ; "Short" contacts of already activated T cells last a random time and determine the level of activation.
    [  
      ifelse ( a_level > thresh_level )
        [
          set state 5
          set cnt_1 0
        ]
        [
          set state 3
          set cnt_1 0
        ]  
    ]
  ]
end

to
  change-state ; Transition to the desesitization state
  
  ask turtles with [affinity = 1] with [effectiveness != 1]
    [
     if cnt_4 = 20
       [
        set state 3
        set cnt_4 0
       ]  
    ]
end

to
  duration-count  ; Duration of desensitization
  ask turtles with [affinity = 1] with [effectiveness != 1]
   [ if state = 3 and pcolor = 47.9
     [
       set cnt_3 cnt_3 + 1
     ]
   ]      
end

to
  wake  ; Transition from a desensitization chemokine state to a base chemokine-sensitive state
  ask turtles with [affinity = 1] with [effectiveness != 1]
    [
     if cnt_3 = 20
       [
        set state 0
        set cnt_3 0
 
       ]  
    ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Code part on the cognate cells division
to
  calculate-neighbors
   ask turtles 
     [
      set nn count turtles-on neighbors
       
      set nh count turtles-on patch-here
            
      
      ;set nbp count neighbors with [pcolor = black] 
     ]
     
end


to
  wait-replication  ; Time to the division start
  ask turtles with [affinity = 1]
   [ if state = 5
     [
       set cnt_5 cnt_5 + 1
     ]
   ]      
end

to
  divide  ; After 8 hours, division occurs.
  ask turtles with [state = 5] with [num_gen <= max_div - 1 ]
    [  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;calculate-n
       
       ;set nn sum [count turtles-here] of neighbors
 
       ;set nbp count neighbors with [pcolor = 0]
 
       ;set nh count turtles-on patch-here
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;Search-place
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
       let free-patches patches in-radius Division_rad with [pcolor != black] with [count turtles-here = 0]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; replicate
      
     if cnt_5 >= doubling_time and any? free-patches
       [set state 0
        set cnt_5 0
        set contact_flag 1
        set activity 1                                                  
        set num_gen num_gen + 1
        
        hatch 1 
         [ ;setxy x_free y_free
           set color red
           set affinity 1
           set activity 1                                      ;;;;;;;;;;;;;;; New activated T cell occurs
           set effectiveness 0 
           set num_gen num_gen
           set state 0
           set cnt_5 0
           set cnd 0
           set size 1
           set crt_time ticks
           set contact_flag 0
           set doubling_time round random-normal 960 150                   ; New activated T cell occurs => you must immediately set the division time
           set activation_time round random-normal 2880 250
           set a_level a_level
           move-to one-of free-patches ;;;
         ]
 
       ]  
    ]
end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Code part for life-time count

to
  life-count  
  ask turtles with [effectiveness = 1]
   [
     set cnd cnd + 1
   ]      
end

to
  kill-effectors  
  ask turtles with [effectiveness = 1]
   [
     if cnd > life-time
       [die]
   ]      
end

to
  recolor
  ask turtles with [affinity = 1] with [activity = 1]
    [
     if num_gen = max_div
       [ 
         set color orange
         set effectiveness 1 
       ]
           
    ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; End of T cell states changig code part
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to              ; Calculation of T cell activation level
  calculate-level
  ask turtles with [affinity = 1 and activity = 1]
   [
     ifelse state = 1
     [set a_level zero_level + 2.0 / ( 1 + exp (- 0.01 * cnt_1) ) ]
     
     [set a_level a_level - lambda  * a_level]  
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
  ;set Sum_sch_time sum [sch_time] of turtles
  ;set Mean_sch_time Sum_sch_time / amount_cont_cells
  
  ifelse amount_cont_cells != 0
  [set Mean_sch_time Sum_sch_time / amount_cont_cells]
  [set Mean_sch_time "N/A"]
end

to
  calculate_cognate_cells
    if what-a-output? = "Cognate clones number"
      [ output-type ticks / 2
        output-type " "
        output-print count turtles with [affinity = 1]
      ]
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
61
106
124
139
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
61
159
124
192
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

MONITOR
23
869
116
914
Non-cognate cells
count turtles with [color = grey]
17
1
11

MONITOR
22
791
116
836
Cognate cells
count turtles with [affinity = 1]
17
1
11

PLOT
1175
457
1645
850
plot 1
Time
Number of cognate cells
0.0
20.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -2674135 true "" "plot count turtles with [color = red]"
"pen-1" 1.0 0 -955883 true "" "plot count turtles with [color = orange]"
"pen-2" 1.0 0 -16777216 true "" "plot count turtles with [affinity = 1]"

INPUTBOX
168
318
276
378
number
1999
1
0
Number

MONITOR
1166
15
1285
60
NIL
amount_gone_cells
17
1
11

MONITOR
1406
18
1522
63
NIL
amount_cont_cells
17
1
11

SWITCH
166
701
307
734
show-gradient?
show-gradient?
0
1
-1000

CHOOSER
128
747
307
792
what-a-boundary?
what-a-boundary?
"entire adsorbing border" "120 patches" "64 patches" "60 patches" "52 patches" "40 patches" "32 patches" "28 patches" "20 patches" "8 patches" "no passage"
6

INPUTBOX
164
197
275
257
sim_time
20160
1
0
Number

TEXTBOX
164
178
295
206
Simulation time (in ticks):
11
0.0
1

OUTPUT
1670
127
1863
850
12

CHOOSER
1637
18
1816
63
what-a-output?
what-a-output?
"Transit time" "Unique contacts" "Cognate clones output" "Cognate clones number" 3
4

MONITOR
1287
249
1469
294
Cognate clones output:
am_gone_red_cells
17
1
11

INPUTBOX
164
437
273
497
Prob_chem
3
1
0
Number

TEXTBOX
159
404
309
432
Probability of chemotaxis driven motion towards DC:
11
0.0
1

TEXTBOX
24
773
106
791
Cognate clones:
11
0.0
1

INPUTBOX
16
436
124
498
ncc
1
1
0
Number

TEXTBOX
18
402
131
430
Initial number of cognate clones:
11
0.0
1

TEXTBOX
177
283
298
325
Initial number of noncognate clones:
11
0.0
1

MONITOR
1287
325
1475
370
Died cognate clones number:
dying_cells
17
1
11

BUTTON
162
24
274
57
Video capture
make-movie
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
15
555
120
615
Division_rad
3
1
0
Number

TEXTBOX
13
522
150
564
Search radius of free patch during cell division:
11
0.0
1

INPUTBOX
163
106
275
166
max_div
10
1
0
Number

TEXTBOX
150
88
300
116
Maximum number of divisions:
11
0.0
1

INPUTBOX
161
555
270
615
influx_rate
50
1
0
Number

TEXTBOX
162
538
312
556
Cognate cell frequency:
11
0.0
1

INPUTBOX
17
317
123
379
lambda
2.41E-4
1
0
Number

TEXTBOX
30
286
122
328
Stimulation signal decay rate:
11
0.0
1

SLIDER
166
646
307
679
thresh_level
thresh_level
0
10
3.5
0.1
1
NIL
HORIZONTAL

INPUTBOX
14
646
120
706
life-time
2880
1
0
Number

TEXTBOX
29
631
122
649
Effector life-time:
11
0.0
1

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
