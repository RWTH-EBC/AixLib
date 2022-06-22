within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control.TwoPositionController.BaseClasses;
partial model partialTwoPositionController
  "Base model for the two position controller"
  //Parameters
 parameter Modelica.SIunits.Temperature Tref=273.15 + 60
                                                       "Reference Temperature for the on off controller";
 parameter Integer n  "Number of layers in the buffer storage";
 parameter Boolean variablePLR=false "If true, the user can determine the PLR between PLRmin and 1; else you have a two position conttol with the values 0 and 1 for PLR";

  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=bandwidth,
                                                          pre_y_start=true)
    annotation (Placement(transformation(extent={{32,-4},{52,16}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Tref)
    annotation (Placement(transformation(extent={{2,20},{22,40}})));

  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{72,-4},{92,16}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{94,-4},{114,16}}),
        iconTransformation(extent={{94,-4},{114,16}})));
  Modelica.Blocks.Sources.RealExpression realZero
    annotation (Placement(transformation(extent={{36,-30},{56,-10}})));
  Modelica.Blocks.Interfaces.RealInput PLRin
    annotation (Placement(transformation(extent={{-120,70},{-80,110}})));
  Modelica.Blocks.Interfaces.RealInput TLayers[n] "Temperatures of the different layers of the buffer storage"
    annotation (Placement(transformation(extent={{-120,-42},{-80,-2}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-34,58},{-10,82}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-120,14},{-80,54}})));
  Modelica.Blocks.Sources.RealExpression realExpression1
    annotation (Placement(transformation(extent={{10,52},{28,68}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{38,58},{62,82}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=1)
    annotation (Placement(transformation(extent={{-82,52},{-70,68}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=variablePLR)
    annotation (Placement(transformation(extent={{-82,62},{-70,80}})));
  parameter Real bandwidth     "Bandwidth around reference signal";

 Boolean isOnMea;
equation
if PLRset >0 then
    isOnMea=true;
  else
     isOnMea=false;
  end if;


  connect(realExpression.y, onOffController.reference) annotation (Line(points={{23,30},
          {26,30},{26,12},{30,12}},         color={0,0,127}));
  connect(switch1.y, PLRset)
    annotation (Line(points={{93,6},{104,6}},   color={0,0,127}));
  connect(realZero.y, switch1.u3) annotation (Line(points={{57,-20},{60,-20},{
          60,-2},{70,-2}},
                    color={0,0,127}));
  connect(onOffController.y, switch1.u2)
    annotation (Line(points={{53,6},{70,6}},   color={255,0,255}));
  connect(PLRin, switch2.u1)
    annotation (Line(points={{-100,90},{-64,90},{-64,79.6},{-36.4,79.6}},
                                                  color={0,0,127}));
  connect(switch2.y, switch3.u1)
    annotation (Line(points={{-8.8,70},{-4,70},{-4,79.6},{35.6,79.6}},
                                               color={0,0,127}));
  connect(switch3.y, switch1.u1) annotation (Line(points={{63.2,70},{66,70},{66,
          14},{70,14}},
                    color={0,0,127}));
  connect(booleanExpression.y, switch2.u2) annotation (Line(points={{-69.4,71},
          {-34.65,71},{-34.65,70},{-36.4,70}},
                                             color={255,0,255}));
  connect(realExpression2.y, switch2.u3) annotation (Line(points={{-69.4,60},{
          -36,60},{-36,60.4},{-36.4,60.4}},
                                      color={0,0,127}));
  connect(isOn, switch3.u2) annotation (Line(points={{-100,34},{-80,34},{-80,54},
          {0,54},{0,70},{35.6,70}},
                                  color={255,0,255}));
  connect(realExpression1.y, switch3.u3) annotation (Line(points={{28.9,60},{
          29.4,60},{29.4,60.4},{35.6,60.4}},
                                       color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Partial model for the two position control of heat heat generators. The temperature control can be switched on and off via the isOn input from the outside. The user can set the controller with the parameters Tset and bandwidth.</p>
</html>"));
end partialTwoPositionController;
