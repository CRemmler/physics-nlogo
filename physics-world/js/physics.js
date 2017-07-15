//physics.js
var socket;
var universe;

Physics = (function() {
  var world;
  var physicsWorld;
  var running = false;
  
   // get ready to capture mouse events
  var isMouseDown = false;
  var mouseX = undefined;
  var mouseY = undefined;
  var p, canvasPosition;
  var selectedBody;
  var mouseJoint = null;
  var mousePVec;
  
  var   b2Vec2 = Box2D.Common.Math.b2Vec2
     ,	b2BodyDef = Box2D.Dynamics.b2BodyDef
     ,	b2Body = Box2D.Dynamics.b2Body
     ,	b2FixtureDef = Box2D.Dynamics.b2FixtureDef
     ,	b2Fixture = Box2D.Dynamics.b2Fixture
     ,	b2World = Box2D.Dynamics.b2World
     ,	b2MassData = Box2D.Collision.Shapes.b2MassData
     ,	b2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape
     ,	b2CircleShape = Box2D.Collision.Shapes.b2CircleShape
     ,	b2DebugDraw = Box2D.Dynamics.b2DebugDraw
     ,  b2AABB = Box2D.Collision.b2AABB
     ,  b2MouseJointDef = Box2D.Dynamics.Joints.b2MouseJointDef
     ;
  var bodyObj = {};
  var SCALE = 30;
  var BOX2D_WIDTH = 0; 
  var BOX2D_HEIGHT = 0; 
  var NLOGO_WIDTH = 0; 
  var NLOGO_HEIGHT = 0;
  // assume NetLogo world is centered at 0
  
  function nlogotobox2d(coords) {
    //console.log("nlogotobox2d", coords);
    BOX2D_WIDTH = parseFloat($("#box2d-canvas").css("width").replace("px",""));
    BOX2D_HEIGHT = parseFloat($("#box2d-canvas").css("height").replace("px",""));
    var nlogoLeftAbsolute = coords[0] + NLOGO_WIDTH / 2;
    var nlogoLeftPercent = nlogoLeftAbsolute / NLOGO_WIDTH;
    var box2dLeftAbsolute = BOX2D_WIDTH * nlogoLeftPercent;
    var nlogoTopAbsolute = NLOGO_HEIGHT / 2 - coords[1];
    var nlogoTopPercent = nlogoTopAbsolute / NLOGO_HEIGHT;
    var box2dTopAbsolute = BOX2D_HEIGHT * nlogoTopPercent;
    //console.log([ box2dLeftAbsolute, box2dTopAbsolute]);
    return ([ box2dLeftAbsolute, box2dTopAbsolute]);
  };
  
  function box2dtonlogo(coords) {
    //console.log("box2dtonlogo",coords);
    BOX2D_WIDTH = parseFloat($("#box2d-canvas").css("width").replace("px",""))
    BOX2D_HEIGHT = parseFloat($("#box2d-canvas").css("height").replace("px",""))
    var box2dLeftAbsolute = coords.x;
    var box2dLeftPercent = coords.x / BOX2D_WIDTH;
    var nlogoLeftAbsolute = NLOGO_WIDTH * box2dLeftPercent - (NLOGO_WIDTH / 2);
    var box2dTopAbsolute = coords.y;
    var box2dTopPercent = coords.y / BOX2D_HEIGHT;
    var nlogoTopAbsolute = (NLOGO_HEIGHT / 2) - NLOGO_HEIGHT * box2dTopPercent;
    return ({x: nlogoLeftAbsolute, y: nlogoTopAbsolute});
  };

  //Physics.createWorld([10, [21, 21] ])
  function createWorld(m) {
    bindElements();
    var gravity = m[0];
    var range = m[1];
    NLOGO_WIDTH = range[0];
    NLOGO_HEIGHT = range[1];

    world = new b2World(
          new b2Vec2(0, gravity)    //gravity
       ,  true                 //allow sleep
    );
  }

  function startWorld() {
    if (world) {
      for (var id in bodyObj) {
        //coords = bodyObj[id].GetPosition();
        //console.log("before",coords);
        //newCoords = box2dtonlogo(coords);
        //console.log("id "+id+" "+newCoords.x+" "+newCoords.y)      
      }
      
      
      
      p = $( "#box2d-canvas");
      canvasPosition = p.position();
      physicsWorld = window.setInterval(update, 1000 / 60);
      running = true;
    }
  }
        
  function stopWorld() {
    var coords, newCoords;
    for (var id in bodyObj) {
      //coords = bodyObj[id].GetPosition();
      //console.log("before",coords);
      //newCoords = box2dtonlogo(coords);
      //console.log("id "+id+" "+newCoords.x+" "+newCoords.y)
      //universe.model.turtles[id].xcor = newCoords.x;
      //universe.model.turtles[id].ycor = newCoords.y;
//      console.log(universe.model.turtles[id].xcor+", "+universe.model.turtles[id].ycor);
    
    }
    update();
    window.clearInterval(physicsWorld);
    running = false;
  }
        
  function addBody(m) {
    var id = m[0];
    var behavior = m[1];
    var bodyA = m[2]
    var nlogoCoords = m[3];
    var box2dCoords = nlogotobox2d(nlogoCoords);
    console.log("add body "+id+" "+behavior+" "+bodyA+" "+nlogoCoords+" "+box2dCoords);
    var bodyDef = new b2BodyDef;
    switch (behavior) {
      case "static":
        bodyDef.type = b2Body.b2_staticBody;          
        break;
      case "dynamic":
        bodyDef.type = b2Body.b2_dynamicBody;            
        break;
      case "ghost":
        bodyDef.type = b2Body.b2_kineticBody;            
        break;
    }
    bodyDef.position.x = roundToTenths(box2dCoords[0] / SCALE * 2 );
    bodyDef.position.y = roundToTenths(box2dCoords[1] / SCALE * 2 );
    bodyDef.userData = {
      id: id,
      selected: false
    }
    bodyObj[id] = world.CreateBody(bodyDef);
  }
  
  function roundToTenths(x) {
    return Math.round(x * 100) / 100;
  }
  function addFixtureToBody(m) {
    var id = m[0];
    var bodyA = m[1];
    var nlogoCoords = m[2];
    var box2dCoords = nlogotobox2d(nlogoCoords);
    var nlogoFixtureCoords = m[3];
              var box2dFixtureCoords = [];
    for (let coord of nlogoFixtureCoords) {
      box2dFixtureCoords.push(nlogotobox2d(coord));  
    }
    var shape = m[4];
    var settings = m[5];
    console.log("addFixtureToBody "+id+" "+bodyA+" "+nlogoCoords+" "+shape+" "+settings);
    var fixDef = new b2FixtureDef;
    fixDef.density = settings[0];
    fixDef.friction = settings[1];
    fixDef.restitution = settings[2];
    //var offsetX = bodyObj[bodyA].getPosition().x;
    //var offsetY = bodyObj[bodyA].getPosition().y;
    if (shape === "circle") {
      var distance = findDistance(box2dFixtureCoords[0], box2dFixtureCoords[1]);
      fixDef.shape = new b2CircleShape(distance / 2 / SCALE);
    } else {
      fixDef.shape = new b2PolygonShape; 
      var carp = [];
      for (var i=box2dFixtureCoords.length-1;i>=0;i--){
        carp.push(new b2Vec2(roundToTenths(box2dFixtureCoords[i][0] / SCALE * 2), roundToTenths(box2dFixtureCoords[i][1] / SCALE * 2)))
      }
      fixDef.shape.SetAsArray(carp,carp.length);
    }
    bodyObj[bodyA].CreateFixture(fixDef);
  }
  function addTargetToBody(m) {
    var id = m[0];
    var bodyA = m[1];
    var coords = m[2];
    console.log("addTargetToBody "+id+" "+bodyA+" "+coords);
  }
  function addJointToBody(m) {
    var id = m[0];
    var bodyA = m[1];
    var bodyB = m[2];
    var coords = m[3];
    console.log("addJointToBody "+id+" "+bodyA+" "+bodyB+" "+coords);
  }
  function setupDebugDraw() {
    console.log("setup debug draw box2d");
    //setup debug draw
    var debugDraw = new b2DebugDraw();
     debugDraw.SetSprite(document.getElementById("box2d-canvas").getContext("2d"));
     debugDraw.SetDrawScale(30.0);
     debugDraw.SetFillAlpha(0.3);
     debugDraw.SetLineThickness(1.0);
     debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
     world.SetDebugDraw(debugDraw);
  }

  function findDistance(coord1, coord2) {
    var changeInX = coord2[0] - coord1[0];
    var changeInY = coord2[1] - coord1[1];
    return Math.sqrt(changeInX^2 + changeInY^2);
  }

  function update() {
    if (running) {
      console.log("update");
      universe.repaint();
      world.Step(
             1 / 60   //frame-rate
          ,  10       //velocity iterations
          ,  10       //position iterations
      );
      world.DrawDebugData();
      world.ClearForces();
      // mouse drags images
      if(isMouseDown && (!mouseJoint)) {
        console.log("mouse down and not a joint");
        var body = getBodyAtMouse();
        if(body) {
          console.log("there is a body");
          
          if (!body.m_userData.selected) {
            for (b = world.GetBodyList() ; b; b = b.GetNext())
            {
              if (b.GetType() == b2Body.b2_dynamicBody)
              {
                if (b.m_userData.selected) {
                  b.m_userData.selected = false;
                }
              }
            }
            body.m_userData.selected = true;
          }
          var md = new b2MouseJointDef();
          md.bodyA = world.GetGroundBody();
          md.bodyB = body;
          md.target.Set(mouseX, mouseY);
          md.collideConnected = true;
          md.maxForce = 300.0 * body.GetMass();
          mouseJoint = world.CreateJoint(md);
          body.SetAwake(true);
        }
      }
      if(mouseJoint) {
        if(isMouseDown) {
          mouseJoint.SetTarget(new b2Vec2(mouseX, mouseY));
        } else {
          world.DestroyJoint(mouseJoint);
          mouseJoint = null;
        }
      }
    }
  };
     
  function getRunning() {
    return running;
  }

   var handleMouseMove = function(e) {
     mouseX = (e.clientX - canvasPosition.left) / SCALE;
     mouseY = (e.clientY - canvasPosition.top) / SCALE;
   };
   
   var handleTouchMove = function(e) {
     e.preventDefault();
     var orig = e.originalEvent;
     mouseX = (orig.touches[0].pageX - canvasPosition.left) / SCALE;
     mouseY = (orig.touches[0].pageY - canvasPosition.left) / SCALE;
     //$('#comment').text('(' + mouseX + ',' + mouseY + ')');
   };

   function getBodyAtMouse() {
     console.log("get body at mouse");
     mousePVec = new b2Vec2(mouseX, mouseY);
     var aabb = new b2AABB();
     aabb.lowerBound.Set(mouseX - 0.001, mouseY - 0.001);
     aabb.upperBound.Set(mouseX + 0.001, mouseY + 0.001);
     // Query the world for overlapping shapes.
     selectedBody = null;
     world.QueryAABB(getBodyCB, aabb);
     return selectedBody;
   }
     
   function getBodyCB(fixture) {
     console.log("get body cb");
     if(fixture.GetBody().GetType() != b2Body.b2_staticBody) {
       if(fixture.GetShape().TestPoint(fixture.GetBody().GetTransform(), mousePVec)) {
         selectedBody = fixture.GetBody();
         console.log("picked selectedBody");
         return false;
       }
     }
     return true;
   }
   
   function bindElements() {
     $('#box2d-canvas').bind('mouseout', function(event) {
       $('#box2d-canvas').unbind('mousemove', handleMouseMove);
       isMouseDown = false;
       mouseX = undefined;
       mouseY = undefined;
     });
     $('#box2d-canvas').bind('mousedown', function(event) {
       isMouseDown = true;
       $('#box2d-canvas').bind('mousemove', handleMouseMove);
     });
     $('#box2d-canvas').bind('touchstart', function(event) {
       isMouseDown = true;
       $('#box2d-canvas').bind('touchmove', handleTouchMove);
     });
     $('#box2d-canvas').bind('mouseup', function(event) {
       $('#box2d-canvas').unbind('mousemove', handleMouseMove);
       isMouseDown = false;
       mouseX = undefined;
       mouseY = undefined;
     });
    $('#box2d-canvas').bind('touchend', function(event) {
       $('#box2d-canvas').unbind('touchmove', handleTouchMove);
       isMouseDown = false;
       mouseX = undefined;
       mouseY = undefined;
    }); 
  }

  function getWorld() {
    return world;
  }
  
  function getBodyObj(id) {
    return bodyObj[id];
  }


  return {
    startWorld: startWorld,
    stopWorld: stopWorld,
    world: world,
    running: getRunning,
    update: update,
    addBody: addBody,
    addFixtureToBody: addFixtureToBody,
    addTargetToBody: addTargetToBody,
    addJointToBody: addJointToBody,
    createWorld: createWorld,
    setupDebugDraw: setupDebugDraw,
    getWorld: getWorld,
    getBodyObj: getBodyObj
    
  };

})();