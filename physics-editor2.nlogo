turtles-own [
  type-of-turtle ;; body, fixture, joint or target

  selected? ;; target, body
  default-color ;; target, body, fixture, to return to after being selected

  body-behavior
  body-A-id ;; fixture, joint, target
  body-B-id ;; joint
  coords ;; body, fixture, target

  fixture-index ;; fixture-coords index
  fixture-coords ;; helpers for fixture
  fixture-id
  fixture-settings
  fixture-shape
  fixture-circle-coords ;; helpers for fixtures that are circles

  joint-index ;; joint-coords index
  joint-coords ;; helpers for joints
  joint-id

  old-body-id ;; body

  angle

  id ;; fixutre, joint, target

]

;;;;;;;;;;;;;;;;;;;
;; CONTROL WORLD ;;
;;;;;;;;;;;;;;;;;;;

to start-world
end

to stop-world
end

to save-setup
 set code-to-setup-my-world ""
 let old-body-A-id -1
 let old-body-B-id -1
 let body-A -1
 let body-B -1
 let body-list (list)

 set code-to-setup-my-world (word code-to-setup-my-world "clear-all \n")

 ask turtles with [type-of-turtle = "body"] [
   set code-to-setup-my-world (word code-to-setup-my-world "create-turtles 1 [ \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set type-of-turtle \"body\" \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set coords " coords " \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set body-behavior \"" body-behavior "\" \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set body-A-id " who " \n")
;   set code-to-setup-my-world (word code-to-setup-my-world "  set id " who " \n")

   set code-to-setup-my-world (word code-to-setup-my-world "  set heading " heading " \n")
   set code-to-setup-my-world (word code-to-setup-my-world "]  \n")
   set body-list lput who body-list
 ]

  ask turtles with [type-of-turtle = "fixture"] [
   set code-to-setup-my-world (word code-to-setup-my-world "create-turtles 1 [ \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set type-of-turtle \"fixture\" \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set coords " coords " \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set fixture-coords " fixture-coords " \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set fixture-settings " fixture-settings " \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set fixture-shape \"" fixture-shape "\" \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set body-A-id " body-A-id " \n")
;   set code-to-setup-my-world (word code-to-setup-my-world "  set id " who " \n")
   set code-to-setup-my-world (word code-to-setup-my-world "]  \n")
 ]

 ask turtles with [ type-of-turtle = "target" ] [
   set code-to-setup-my-world (word code-to-setup-my-world "create-turtles 1 [ \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set type-of-turtle \"target\" \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set coords " coords " \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set body-A-id " body-A-id " \n")
 ;  set code-to-setup-my-world (word code-to-setup-my-world "  set id " who " \n")
   set code-to-setup-my-world (word code-to-setup-my-world "]  \n")
 ]

  ask turtles with [ type-of-turtle = "joint" ] [
   set code-to-setup-my-world (word code-to-setup-my-world "create-turtles 1 [ \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set type-of-turtle \"joint\" \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set coords " coords " \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set joint-coords " joint-coords " \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set body-A-id " body-A-id " \n")
   set code-to-setup-my-world (word code-to-setup-my-world "  set body-B-id " body-B-id " \n")
 ;  set code-to-setup-my-world (word code-to-setup-my-world "  set id " who " \n")
   set code-to-setup-my-world (word code-to-setup-my-world "]  \n")
 ]


 set code-to-setup-my-world (word code-to-setup-my-world "   ask turtles [\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (type-of-turtle) [ set type-of-turtle \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (selected?) [ set selected? \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (default-color) [ set default-color \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (body-behavior) [ set body-behavior \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (body-A-id ) [ set body-A-id  \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (body-B-id) [ set body-B-id \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (coords) [ set coords \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (fixture-id) [ set fixture-id \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (fixture-settings) [ set fixture-settings \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (fixture-shape) [ set fixture-shape \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (joint-index) [ set joint-index \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (joint-coords) [ set joint-coords \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (joint-id) [ set joint-id \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (old-body-id) [ set old-body-id \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (first-coord-id) [ set first-coord-id \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (prev-coord-id) [ set prev-coord-id \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "     if not (angle) [ set angle \"\" ]\n")
 set code-to-setup-my-world (word code-to-setup-my-world "  ]\n")


 set code-to-setup-my-world (word code-to-setup-my-world "ask turtles with [ type-of-turtle = \"body\"] [\n")
 set code-to-setup-my-world (word code-to-setup-my-world "  set id who\n")
 set code-to-setup-my-world (word code-to-setup-my-world "  let old-who body-A-id\n")
 set code-to-setup-my-world (word code-to-setup-my-world "  let new-who who \n")
 set code-to-setup-my-world (word code-to-setup-my-world "  ask turtles with [ body-A-id = old-who ] [ set id who set body-A-id new-who ] \n")
 set code-to-setup-my-world (word code-to-setup-my-world "  ask turtles with [ body-B-id = old-who ] [ set id who set body-B-id new-who ] \n")
 set code-to-setup-my-world (word code-to-setup-my-world "] \n")

 set code-to-setup-my-world (word code-to-setup-my-world "physics-eval \"create world\" (list " gravity " (list " world-height " " world-width ") ) \n")
 set code-to-setup-my-world (word code-to-setup-my-world "ask turtles with [ type-of-turtle = \"body\" ] [\n")
 set code-to-setup-my-world (word code-to-setup-my-world "  physics-eval \"add body\" ( list id body-behavior body-A-id coords heading )\n")
 set code-to-setup-my-world (word code-to-setup-my-world "]  \n")
 set code-to-setup-my-world (word code-to-setup-my-world "ask turtles with [ type-of-turtle = \"fixture\" ] [ \n")
 set code-to-setup-my-world (word code-to-setup-my-world "   physics-eval \"add fixture to body\" (list id body-A-id coords fixture-coords fixture-shape fixture-settings heading) \n")
 set code-to-setup-my-world (word code-to-setup-my-world "]  \n")
 set code-to-setup-my-world (word code-to-setup-my-world "ask turtles with [ type-of-turtle = \"target\" ] [  \n")
 set code-to-setup-my-world (word code-to-setup-my-world "  physics-eval \"add target to body\" (list id body-A-id coords ) \n")
 set code-to-setup-my-world (word code-to-setup-my-world "]  \n")
 set code-to-setup-my-world (word code-to-setup-my-world "ask turtles with [ type-of-turtle = \"joint\" ] [  \n")
 set code-to-setup-my-world (word code-to-setup-my-world "  physics-eval \"add joint to body\" (list id body-A-id body-B-id joint-coords ) \n")
 set code-to-setup-my-world (word code-to-setup-my-world "]  \n")
 set code-to-setup-my-world (word code-to-setup-my-world "physics-eval \"setup debug draw\" (list) ;; OPTIONAL  \n")
 set code-to-setup-my-world (word code-to-setup-my-world "setup-debug-draw ;; OPTIONAL  \n")

end

;;;;;;;;;;;;;;;;;
;; DEMO WORLDS ;;
;;;;;;;;;;;;;;;;;

to donuts-in-space

end

to car-on-a-hill
  clear-all
end

to bouncy-balls-on-tray

end

to setup-debug-draw
  remove-debug-draw
  let index 0
  let first-coord-id -1
  let prev-coord-id -1
  ask turtles with [ type-of-turtle = "body" ] [
    show-turtle
    setxy item 0 coords item 1 coords
    ifelse (body-behavior = "dynamic") [ set shape "star" ] [ ifelse (body-behavior = "static") [ set shape "square" ] [ set shape "ghost" ] ]
    set color violet
    set size 1
    setxy item 0 coords item 1 coords
    set label id
    set selected? false
    set heading 0
  ]
  ask turtles with [ type-of-turtle = "fixture" ] [
    set first-coord-id -1
    set prev-coord-id -1
    show-turtle
    set shape "circle 2"
    ;;set color random 14 * 10 + 2
    set color length fixture-coords * 20 + 44
    if (fixture-shape = "circle") [ set color 20 + 44 ]
    set default-color color
    set size 1
    setxy item 0 coords item 1 coords
    set label body-A-id
    let body-A body-A-id
    set index 0
    set selected? false
    (foreach fixture-coords
      [ [coord] ->
        hatch 1 [
          show-turtle
          set fixture-index index
          set index index + 1
          set type-of-turtle "fixture-coords"
          setxy item 0 coord item 1 coord
          set shape "circle"
          ifelse (first-coord-id = -1 and fixture-shape = "circle")
          [ set label "x  " set label-color black ]
          [ set label "" ]
          set size 0.75
          ifelse (first-coord-id = -1) [
            set first-coord-id who
          ]
          [ create-link-with turtle prev-coord-id ]
          set prev-coord-id who
        ] ] )
     ask turtle prev-coord-id [ create-link-with turtle first-coord-id ]
  ]
  ask turtles with [ type-of-turtle = "target" ] [
    show-turtle
    set shape "triangle"
    set color red
    set size 0.75
    setxy item 0 coords item 1 coords
    set label body-A-id
    set selected? false
  ]
  ask turtles with [ type-of-turtle = "joint" ] [
    show-turtle
    set shape "circle 2"
    set color blue
    set size 1
    setxy item 0 coords item 1 coords
    set label (word body-A-id ", " body-B-id)
    set selected? false

    let coord item 0 joint-coords
    hatch 1 [
      show-turtle
      set joint-index 0
      set type-of-turtle "joint-coords"
      setxy item 0 coord item 1 coord
      set shape "circle"
      set label ""
      set size 0.75
      create-link-with turtle body-A-id
      set prev-coord-id who
    ]
    set coord item 1 joint-coords
    hatch 1 [
      show-turtle
      set joint-index 1
      set type-of-turtle "joint-coords"
      setxy item 0 coord item 1 coord
      set shape "circle"
      set label ""
      set size 0.75
      create-link-with turtle body-B-id
      create-link-with turtle prev-coord-id
    ]
  ]

end

to remove-debug-draw
  ask turtles with [ type-of-turtle = "body" ] [ hide-turtle ]
  ask turtles with [ type-of-turtle = "fixture" ] [ set label ""]
  ask turtles with [ type-of-turtle = "fixture-coords" ] [ die ]
  ask turtles with [ type-of-turtle = "target" ] [ hide-turtle ]
  ask turtles with [ type-of-turtle = "joint" ] [ hide-turtle ]
  ask turtles with [ type-of-turtle = "joint-coords" ] [ die ]
end

to my-world
clear-all
create-turtles 1 [
  set type-of-turtle "body"
  set coords [-4.41 2.35]
  set body-behavior "dynamic"
  set body-A-id 6
  set id 6
]
create-turtles 1 [
  set type-of-turtle "body"
  set coords [-4.19 -6.16]
  set body-behavior "static"
  set body-A-id 0
  set id 0
]
create-turtles 1 [
  set type-of-turtle "body"
  set coords [-2.75 -1.59]
  set body-behavior "dynamic"
  set body-A-id 59
  set id 59
]
create-turtles 1 [
  set type-of-turtle "fixture"
  set coords [-3.74 1.05]
  set fixture-coords [[-2.89 2.62] [-4.74 1.05] [-3.74 0.05] [-0.65 -0.16]]
  set fixture-settings [0.8 0.5 0.8]
  set fixture-shape "quadrilateral"
  set body-A-id 6
  set id 9
]
create-turtles 1 [
  set type-of-turtle "fixture"
  set coords [-4.86 -8.35]
  set fixture-coords [[9.2 -8.57] [-9.2 -8.53]]
  set fixture-settings [0.8 0.5 0.8]
  set fixture-shape "edge"
  set body-A-id 0
  set id 1
]
create-turtles 1 [
  set type-of-turtle "fixture"
  set coords [-1.28 5.93]
  set fixture-coords [[0.34 2.9] [-2.8 2.66] [-0.6 -0.07]]
  set fixture-settings [0.8 0.5 0.8]
  set fixture-shape "triangle"
  set body-A-id 6
  set id 20
]
create-turtles 1 [
  set type-of-turtle "fixture"
  set coords [3.65 -1.63]
  set fixture-coords [[-1.19 -5.04] [0.16 -3.43]]
  set fixture-settings [0.8 0.5 0.8]
  set fixture-shape "circle"
  set body-A-id 59
  set id 69
]

end

;;;;;;;;;;;;;;;;
;; EDIT WORLD ;;
;;;;;;;;;;;;;;;;

to drag
  let dragger-id -1
  let dragger-type ""
  let body-A -1
  let body-B -1
  let joint -1
  let fixture -1
  let fixture-ind -1
  let joint-ind -1
  every 0.1 [
    if (mouse-down?) [
      ask patch mouse-xcor mouse-ycor [

        ;; set dragging of body
        if count turtles-here with [ type-of-turtle = "body" ] > 0 [
          set dragger-type "body"
          ask one-of turtles-here with [type-of-turtle = "body" ] [
            set dragger-id who
          ]
        ]

        ;; set dragging of fixture
        if count turtles-here with [ type-of-turtle = "fixture" ] > 0 [
          set dragger-type "fixture"
          ask one-of turtles-here with [type-of-turtle = "fixture" ] [
            set dragger-id who
          ]
        ]

        ;; set dragging of fixture-coords
        if count turtles-here with [ type-of-turtle = "fixture-coords" ] > 0 [
          set dragger-type "fixture-coords"
          ask one-of turtles-here with [type-of-turtle = "fixture-coords" ] [
            set dragger-id who
          ]
        ]

        ;; set dragging of target
        if count turtles-here with [ type-of-turtle = "target" ] > 0 [
          set dragger-type "target"
          ask one-of turtles-here with [type-of-turtle = "target" ] [
            set dragger-id who
          ]
        ]

        ;; set dragging of joint
        if count turtles-here with [ type-of-turtle = "joint" ] > 0 [
          set dragger-type "joint"
          ask one-of turtles-here with [type-of-turtle = "joint" ] [
            set dragger-id who
          ]
        ]

        ;; set dragging of joint-coords
        if count turtles-here with [ type-of-turtle = "joint-coords" ] > 0 [
          set dragger-type "joint-coords"
          ask one-of turtles-here with [type-of-turtle = "joint-coords" ] [
            set dragger-id who
          ]
        ]
      ]

      ;; drag body
      if (dragger-type = "body") [
        while [ mouse-down? ] [
          ask turtle dragger-id [
            setxy mouse-xcor mouse-ycor
            set coords (list precision xcor 2 precision ycor 2)
          ]
        ]
      ]
      ;; drag fixture
      if (dragger-type = "fixture") [
        while [ mouse-down? ] [
          ask turtle dragger-id [
            setxy mouse-xcor mouse-ycor
            set coords (list precision xcor 2 precision ycor 2)
          ]
        ]
      ]
      ;; drag fixture-coords
      if (dragger-type = "fixture-coords") [
        ask turtle dragger-id [
          set body-A body-A-id
          set fixture fixture-id
          set fixture-ind fixture-index
        ]
        while [ mouse-down? ] [
          ask turtle dragger-id [
            set body-A body-A-id
            setxy mouse-xcor mouse-ycor
          ]
        ]
        ask turtle fixture [
           set fixture-coords replace-item fixture-ind fixture-coords (list precision mouse-xcor 2 precision mouse-ycor 2)
        ]
      ]
      ;; drag target
      if (dragger-type = "target") [
        while [ mouse-down? ] [
          ask turtle dragger-id [ setxy mouse-xcor mouse-ycor ]
        ]
        ask turtle dragger-id [ set coords (list precision xcor 2 precision ycor 2)]
      ]

      ;; drag joint
      if (dragger-type = "joint") [
        while [ mouse-down? ] [
          ask turtle dragger-id [ setxy mouse-xcor mouse-ycor ]
        ]
      ]
      ;; drag joint-coords
      if (dragger-type = "joint-coords") [
        ask turtle dragger-id [
          set body-A body-A-id
          set body-B body-B-id
          set joint joint-id
          set joint-ind joint-index
        ]
        while [ mouse-down? ] [
          ask turtle dragger-id [
            set body-A body-A-id
            set body-B body-B-id
            setxy mouse-xcor mouse-ycor
          ]
        ]
        ask turtle joint [
          set joint-coords replace-item joint-ind joint-coords (list mouse-xcor mouse-ycor)
        ]
      ]
    ]
  ]
end

to delete
  let dragger-id -1
  let dragger-type ""
  let body-A -1
  let body-B -1
  let fixture -1
  let joint -1
  every 0.1 [
    if (mouse-down?) [
      ask patch mouse-xcor mouse-ycor [
        if count turtles-here with [ type-of-turtle = "body" ] > 0 [
          ask turtles-here with [type-of-turtle = "body" ] [
            set dragger-id who
            set dragger-type "body"
          ]
        ]
        if count turtles-here with [ type-of-turtle = "fixture" ] > 0 [
          ask turtles-here with [type-of-turtle = "fixture" ] [
            set dragger-id who
            set dragger-type "fixture"
          ]
        ]
        if count turtles-here with [ type-of-turtle = "target" ] > 0 [
          ask turtles-here with [type-of-turtle = "target" ] [
            set dragger-id who
            set dragger-type "target"
          ]
        ]
        if count turtles-here with [ type-of-turtle = "joint" ] > 0 [
          ask turtles-here with [type-of-turtle = "joint" ] [
            set dragger-id who
            set dragger-type "joint"
          ]
        ]
      ]
      if (dragger-type = "body") [
        ask turtle dragger-id [ die ]
        ask turtles with [ body-A-id = dragger-id ] [ die ]
      ]
      if (dragger-type = "fixture") [
        ask turtle dragger-id [
          set body-A body-A-id
          set fixture who
          die
        ]
        ask turtles with [fixture = fixture-id ] [ die ]
      ]
      if (dragger-type = "target") [
        ask turtle dragger-id [ die ]
      ]
      if (dragger-type = "joint") [
        ask turtle dragger-id [
          set joint who
          die
        ]
        ask turtles with [joint = joint-id ] [ die ]
      ]
    ]
  ]
end

to add-body
  every 0.1 [
    if (mouse-down?) [
      create-turtles 1 [
        set type-of-turtle "body"
        set id who
        set body-behavior behavior
        setxy mouse-xcor mouse-ycor
        set coords (list precision xcor 2 precision ycor 2)
        set body-A-id who
        set heading 0
      ]
      setup-debug-draw
      stop
    ]
  ]
end

to add-fixture
  every 0.1 [
    if (mouse-down?) [
      let body-A -1
      if (count turtles with [type-of-turtle = "body" and selected? = true ] > 0 ) [
        ask one-of turtles with [type-of-turtle = "body" and selected? = true ] [ set body-A body-A-id ]
        create-turtles 1 [
          set type-of-turtle "fixture"
          set id who
          set coords (list precision mouse-xcor 2 precision mouse-ycor 2)
          set fixture-settings (list density friction restitution)
          set fixture-shape shape-of-fixture
          set body-A-id body-A
          set fixture-id who
          let num-coords 2
          let temp-fixture-coords (list)
          setxy mouse-xcor mouse-ycor
          if (fixture-shape = "triangle") [ set num-coords 3 ]
          if (fixture-shape = "quadrilateral") [ set num-coords 4 ]
          if (fixture-shape = "pentagon") [ set num-coords 5 ]
          let fixture-angle 360 / num-coords
          while [ num-coords > 0 ] [
            hatch 1 [
              set type-of-turtle "temp-fixture-coords"
              set heading fixture-angle * num-coords
              fd 1
              set temp-fixture-coords lput (list precision xcor 2 precision ycor 2 ) temp-fixture-coords
            ]
            set num-coords num-coords - 1
          ]
          ask turtles with [type-of-turtle = "temp-fixture-coords"] [ die ]
          set fixture-coords temp-fixture-coords
        ]
        setup-debug-draw
        stop
      ]
    ]
  ]
end

to add-joint
  every 0.1 [
    if (mouse-down?) [
      let bodies (list)
      if (count turtles with [type-of-turtle = "body" and selected? = true ] > 0 ) [
        ask turtles with [type-of-turtle = "body" and selected? = true ] [ set bodies lput body-A-id bodies ]
        if (length bodies = 2) [
          create-turtles 1 [
            set type-of-turtle "joint"
            set id who
            set coords (list precision mouse-xcor 2 precision mouse-ycor 2 )
            set body-A-id item 0 bodies
            set body-B-id item 1 bodies
            let temp-joint-coords (list)
            set joint-id who
            setxy mouse-xcor mouse-ycor
            hatch 1 [
              set type-of-turtle "temp-joint-coords"
              set heading 270
              fd 1
              set temp-joint-coords lput (list precision xcor 2 precision ycor 2 ) temp-joint-coords
            ]
            hatch 1 [
              set type-of-turtle "temp-joint-coords"
              set heading 90
              fd 1
              set temp-joint-coords lput (list precision xcor 2 precision ycor 2 ) temp-joint-coords
            ]
            ask turtles with [type-of-turtle = "temp-joint-coords"] [ die ]
            set joint-coords temp-joint-coords
          ]
          setup-debug-draw
          stop
        ]
      ]
    ]
  ]
end

to add-target
  every 0.1 [
    if (mouse-down?) [
      let body-A -1
      if (count turtles with [type-of-turtle = "body" and selected? = true ] > 0 ) [
        ask one-of turtles with [type-of-turtle = "body" and selected? = true ] [ set body-A body-A-id ]
        create-turtles 1 [
          set type-of-turtle "target"
          set id who
          set coords (list precision mouse-xcor 2 precision mouse-ycor 2)
          set body-A-id body-A
        ]
        setup-debug-draw
        stop
      ]
    ]
  ]
end

to update-body
  ask turtles with [ type-of-turtle = "body" and selected? ] [
    set body-behavior behavior
  ]
  setup-debug-draw
end

to update-fixture
  let temp-fixture-coords (list)
  let num-coords 2
  let body-A -1
  if (shape-of-fixture = "triangle") [ set num-coords 3 ]
  if (shape-of-fixture = "quadrilateral") [ set num-coords 4 ]
  if (shape-of-fixture = "pentagon") [ set num-coords 5 ]
  ;;let angle 360 / num-coords
  ask turtles with [ type-of-turtle = "fixture" and selected? ] [
    set fixture-settings (list density friction restitution)
  ]
  remove-debug-draw
  setup-debug-draw
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ADD FORCES/IMPULSES TO WORLD ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to select-target
  every 0.1 [
    if (mouse-down?) [
      ask patch mouse-xcor mouse-ycor [
        if count turtles-here with [ type-of-turtle = "target" ] > 0 [
          ask one-of turtles-here with [type-of-turtle = "target"] [
            ifelse (selected? = true) [
              set selected? false
              set color red
            ] [
              set selected? true
              set color yellow
            ]
          ]
        ]
      ]
    ]
  ]
end

to select-body
  every 0.1 [
    if (mouse-down?) [
      ask patch mouse-xcor mouse-ycor [
        if count turtles-here with [ type-of-turtle = "body" ] > 0 [
          ask one-of turtles-here with [type-of-turtle = "body"] [
            ifelse (selected? = true) [
              set selected? false
              set color violet
            ] [
              ask turtles with [ type-of-turtle = "body" and selected? = true] [ set selected? false set color violet ]
              set selected? true
              set color yellow
              set behavior body-behavior
            ]
          ]
        ]
      ]
    ]
  ]
end

to select-2-bodies
  every 0.1 [
    if (mouse-down?) [
      ask patch mouse-xcor mouse-ycor [
        if count turtles-here with [ type-of-turtle = "body" ] > 0 [
          ask one-of turtles-here with [type-of-turtle = "body"] [
            ifelse (selected? = true) [
              set selected? false
              set color violet
            ] [
              set selected? true
              set color yellow
              set behavior body-behavior
            ]
          ]
        ]
      ]
    ]
  ]
end

to select-fixture
  every 0.1 [
    if (mouse-down?) [
      ask patch mouse-xcor mouse-ycor [
        if count turtles-here with [ type-of-turtle = "fixture" ] > 0 [
          ask one-of turtles-here with [type-of-turtle = "fixture"] [
            ifelse (selected? = true) [
              set selected? false
              set color default-color
            ] [
              ask turtles with [ type-of-turtle = "fixture" and selected? = true ] [ set selected? false set color default-color ]
              set selected? true
              set color yellow
              set shape-of-fixture fixture-shape
              set density item 0 fixture-settings
              set friction item 1 fixture-settings
              set restitution item 2 fixture-settings
            ]
          ]
        ]
      ]
    ]
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
173
11
650
489
-1
-1
22.333333333333332
1
10
1
1
1
0
0
0
1
-10
10
-10
10
0
0
1
ticks
30.0

CHOOSER
658
333
762
378
shape-of-fixture
shape-of-fixture
"edge" "circle" "triangle" "quadrilateral" "pentagon"
1

BUTTON
657
292
760
325
add-fixture
add-fixture
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
768
292
894
325
density
density
0
1
0.8
0.1
1
NIL
HORIZONTAL

SLIDER
766
332
895
365
friction
friction
0
1
0.4
0.1
1
NIL
HORIZONTAL

SLIDER
767
371
896
404
restitution
restitution
0
1
0.3
0.1
1
NIL
HORIZONTAL

CHOOSER
766
174
892
219
behavior
behavior
"static" "ghost" "dynamic"
2

BUTTON
652
503
768
536
add-joint
add-joint
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1029
40
1133
73
NIL
save-setup
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
16
176
157
209
my-world
my-world
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
663
36
803
69
gravity
gravity
0
10
10.0
1
1
NIL
HORIZONTAL

TEXTBOX
709
235
841
253
Create a Fixture
14
0.0
1

BUTTON
663
78
743
111
drag
drag
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
751
78
828
111
delete
delete
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
781
503
880
536
NIL
add-target
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
716
135
816
153
Create a Body
14
0.0
1

TEXTBOX
664
417
779
435
Create a Joint
14
0.0
1

TEXTBOX
666
445
769
497
Select two bodies. Click on a location for the joint.
11
0.0
1

TEXTBOX
672
155
856
183
Click on a location for the body.
11
0.0
1

TEXTBOX
674
255
868
286
Select a body. Click on a location for the fixture.
11
0.0
1

TEXTBOX
777
444
892
486
Select a body. Click on a location for the target.
11
0.0
1

TEXTBOX
773
416
899
434
Create a Target
14
0.0
1

BUTTON
900
173
996
206
NIL
select-body
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
42
16
152
34
DEMO WORLDS
14
0.0
1

BUTTON
17
130
157
163
NIL
bouncy-balls-on-tray
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
19
88
156
121
NIL
car-on-a-hill
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
21
47
157
80
NIL
donuts-in-space
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
672
10
960
31
NETLOGO PHYSICS WORLD EDITOR
14
0.0
1

BUTTON
661
175
758
208
NIL
add-body
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

INPUTBOX
1028
82
1471
543
code-to-setup-my-world
clear-all \ncreate-turtles 1 [ \n  set type-of-turtle \"body\" \n  set coords [-1.54 1.9] \n  set body-behavior \"dynamic\" \n  set body-A-id 0 \n  set heading 0 \n]  \ncreate-turtles 1 [ \n  set type-of-turtle \"fixture\" \n  set coords [0.51 1.46] \n  set fixture-coords [[2.4 -1.14] [-1.5 -1.19]] \n  set fixture-settings [0.8 0.4 0.3] \n  set fixture-shape \"circle\" \n  set body-A-id 0 \n]  \ncreate-turtles 1 [ \n  set type-of-turtle \"fixture\" \n  set coords [-1.72 1.72] \n  set fixture-coords [[-1.81 2.84] [-2.59 1.22] [-0.87 1.1]] \n  set fixture-settings [0.8 0.4 0.3] \n  set fixture-shape \"triangle\" \n  set body-A-id 0 \n]  \n   ask turtles [\n     if not (type-of-turtle) [ set type-of-turtle \"\" ]\n     if not (selected?) [ set selected? \"\" ]\n     if not (default-color) [ set default-color \"\" ]\n     if not (body-behavior) [ set body-behavior \"\" ]\n     if not (body-A-id ) [ set body-A-id  \"\" ]\n     if not (body-B-id) [ set body-B-id \"\" ]\n     if not (coords) [ set coords \"\" ]\n     if not (fixture-id) [ set fixture-id \"\" ]\n     if not (fixture-settings) [ set fixture-settings \"\" ]\n     if not (fixture-shape) [ set fixture-shape \"\" ]\n     if not (joint-index) [ set joint-index \"\" ]\n     if not (joint-coords) [ set joint-coords \"\" ]\n     if not (joint-id) [ set joint-id \"\" ]\n     if not (old-body-id) [ set old-body-id \"\" ]\n     if not (first-coord-id) [ set first-coord-id \"\" ]\n     if not (prev-coord-id) [ set prev-coord-id \"\" ]\n     if not (angle) [ set angle \"\" ]\n  ]\nask turtles with [ type-of-turtle = \"body\"] [\n  set id who\n  let old-who body-A-id\n  let new-who who \n  ask turtles with [ body-A-id = old-who ] [ set id who set body-A-id new-who ] \n  ask turtles with [ body-B-id = old-who ] [ set id who set body-B-id new-who ] \n] \nphysics-eval \"create world\" (list 10 (list 21 21) ) \nask turtles with [ type-of-turtle = \"body\" ] [\n  physics-eval \"add body\" ( list id body-behavior body-A-id coords heading )\n]  \nask turtles with [ type-of-turtle = \"fixture\" ] [ \n   physics-eval \"add fixture to body\" (list id body-A-id coords fixture-coords fixture-shape fixture-settings heading) \n]  \nask turtles with [ type-of-turtle = \"target\" ] [  \n  physics-eval \"add target to body\" (list id body-A-id coords ) \n]  \nask turtles with [ type-of-turtle = \"joint\" ] [  \n  physics-eval \"add joint to body\" (list id body-A-id body-B-id joint-coords ) \n]  \nphysics-eval \"setup debug draw\" (list) ;; OPTIONAL  \nsetup-debug-draw ;; OPTIONAL  \n
1
1
String

BUTTON
915
35
997
70
NIL
clear-all
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
835
78
996
111
NIL
setup-debug-draw
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
835
116
996
149
NIL
remove-debug-draw
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
899
215
996
248
NIL
update-body
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
903
332
1000
365
NIL
update-fixture
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
901
292
999
325
NIL
select-fixture
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
651
545
768
578
NIL
select-2-bodies
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
## WHAT IS IT?

http://www.iforce2d.net/b2dtut/fixtures

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
true
0
Circle -7500403 true true 8 8 284

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

donut
false
3
Circle -6459832 true true 0 0 300
Circle -955883 true false 105 120 0
Circle -16777216 true false 75 75 150

dot
false
0
Circle -7500403 true true 90 90 120

edge
true
0
Line -2674135 false 0 150 300 150

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

ghost
false
0
Polygon -7500403 true true 30 165 13 164 -2 149 0 135 -2 119 0 105 15 75 30 75 58 104 43 119 43 134 58 134 73 134 88 104 73 44 78 14 103 -1 193 -1 223 29 208 89 208 119 238 134 253 119 240 105 238 89 240 75 255 60 270 60 283 74 300 90 298 104 298 119 300 135 285 135 285 150 268 164 238 179 208 164 208 194 238 209 253 224 268 239 268 269 238 299 178 299 148 284 103 269 58 284 43 299 58 269 103 254 148 254 193 254 163 239 118 209 88 179 73 179 58 164
Line -16777216 false 189 253 215 253
Circle -16777216 true false 102 30 30
Polygon -16777216 true false 165 105 135 105 120 120 105 105 135 75 165 75 195 105 180 120
Circle -16777216 true false 160 30 30

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
NetLogo 6.0
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

cat
3.0
-0.2 1 4.0 4.0
0.0 1 2.0 2.0
0.2 1 1.0 0.0
link direction
true
0
Line -7500403 true 150 75 90 105
Line -2674135 false 150 75 210 105
Line -16777216 false 90 105 105 210
Line -16777216 false 165 165 165 165
Rectangle -2064490 false false 105 120 180 180
Line -955883 false 210 105 195 210
Line -2064490 false 180 180 195 210
Line -2064490 false 105 120 90 105
@#$#@#$#@
0
@#$#@#$#@
